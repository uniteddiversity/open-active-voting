require "rubygems"
require "test/unit"
require "watir-webdriver"
require 'test_helper'

class VoteThroughBrowsers < ActionController::IntegrationTest
  WINDOWS =

  def setup
    @max_browsers = 10
    @max_votes = 200
    @db_config = YAML::load(File.read(Rails.root.join("config","database.yml")))
    if !!(RbConfig::CONFIG['host_os'] =~ /mingw|mswin32|cygwin/)
      @browser_types = [:firefox,:chrome,:ie]
    else
      @browser_types = [:firefox,:chrome]
    end

    @browsers = []
    @max_browsers.times do
      @browsers << Watir::Browser.new(@browser_types[rand(@browser_types.length)])
    end
    @votes = []
    @final_votes = Hash.new
    @browsers.each do |browser|
      @final_votes[browser] = []
    end
    setup_votes
  end

  def teardown
    @browsers.each do |browser|
      browser.close
    end
  end

  test "vote_through_firefox_and_chrome" do
    @votes.each do |vote|
      browser = @browsers[rand(@browsers.length)]
      browser.goto "http://localhost:3000/votes/ballot"
      setup_checkboxes(browser,vote)
      @final_votes[browser] << get_final_votes(browser)
      browser.button.click
      browser.div(:id => "success_message").wait_until_present
    end
    assert vote_match?(all_votes), "All individual votes matched"
    assert vote_match?(get_unique_votes,false), "All unique votes matched"
  end

  def get_final_votes(browser)
    construction_votes = []
    browser.elements(:class, "construction_vote_class").each do |element|
      construction_votes << element.id.split("_")[1].to_i
    end
    maintenance_votes = []
    class_elements = browser.elements(:class, "maintenance_vote_class").each do |element|
      maintenance_votes << element.id.split("_")[1].to_i
    end
    [construction_votes,maintenance_votes]
  end

  def all_votes
    all_votes = []
    @final_votes.each do |browser,values|
      all_votes+=values
    end
    all_votes
  end

  def get_unique_votes
    unique_votes = []
    @final_votes.each do |browser,values|
      unique_votes << values.last
    end
    unique_votes
  end

  def vote_match?(votes,count_all_votes=true)
    votes.each do |vote| puts vote.inspect end # DEBUG
    database_count = ReykjavikBudgetVoteCounting.new(Rails.root.join('test','keys','privkey.pem'))
    if count_all_votes
      database_count.count_all_votes
    else
      database_count.count_unique_votes(false)
    end
    puts database_count.inspect
    test_count = ReykjavikBudgetVoteCounting.new(Rails.root.join('test','keys','privkey.pem'))
    test_count.count_all_test_votes(votes)
    puts test_count.inspect
    (test_count.construction_priority_ids_count == database_count.construction_priority_ids_count &&
     test_count.maintenance_priority_ids_count == database_count.maintenance_priority_ids_count) ? true : false
  end

  def setup_votes
    @max_votes.times do
      seen = {}
      construction_votes = (1..(rand(7)+2)).map { |n|
                              x = rand(12)+1
                              while (seen[x])
                                x = rand(12)+1
                              end
                              seen[x]=x
                              x
                            }
      seen = {}
      maintenance_votes = (1..(rand(7)+2)).map { |n|
                              x = rand(12)+14
                              while (seen[x])
                                x = rand(12)+14
                              end
                              seen[x]=x
                              x
                            }

      @votes << [construction_votes,maintenance_votes]
    end
  end

  def setup_checkboxes(browser,vote_types)
    vote_types.each do |vote|
      vote.each do |checkbox_to_set|
        browser.li(:id => "option_#{checkbox_to_set}").click
      end
    end
  end
end