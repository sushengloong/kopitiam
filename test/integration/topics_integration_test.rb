require 'test_helper'

class TopicsIntegrationTest < ActionDispatch::IntegrationTest
  def setup
  end

  def teardown
    Topic.destroy_all
  end

  test 'should display all topics' do
    topic1 = Topic.create title: "Rails 4 has been released!", text: "I love RoR!", link: "http://rubyonrails.org/"
    topic2 = Topic.create title: "Ruby 2 has been released!", text: "I love RoR!", link: "http://ruby-lang.org/"
    
    visit root_path
    assert page.has_content?(topic1.title)
    assert page.has_content?(topic2.title)
  end

  test 'should start a new topic' do
    topic = Topic.new title: "Rails 4 has been released!", text: "I love RoR!", link: "http://rubyonrails.org/"
    visit root_path
    refute page.has_content?(topic.title)
    
    click_link 'Start A Topic'
    fill_in 'Title', with: topic.title
    fill_in 'Text', with: topic.text
    fill_in 'Link', with: topic.link
    click_button 'Submit'

    assert page.has_content?(topic.title)
  end
end
