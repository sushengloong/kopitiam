require 'test_helper'

class TopicsIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    @topic1 = Topic.new title: "Rails 4 has been released!", text: "I love RoR!", link: "http://rubyonrails.org/"
    @topic2 = Topic.new title: "Ruby 2 has been released!", text: "I love RoR!", link: "http://ruby-lang.org/"
  end

  def teardown
    Topic.destroy_all
  end

  test 'should display all topics' do
    @topic1.save && @topic2.save
    visit root_path
    assert page.has_content?(@topic1.title)
    assert page.has_content?(@topic2.title)
  end

  test 'should start a new topic' do
    visit root_path
    refute page.has_content?(@topic1.title)
    
    click_link 'Start New Topic'
    fill_in 'Title', with: @topic1.title
    fill_in 'Text', with: @topic1.text
    fill_in 'Link', with: @topic1.link
    click_button 'Submit'

    assert page.has_content?(@topic1.title)
  end

  test 'should fail to start a new topic without title' do
    visit root_path
    before_count = Topic.count
    
    click_link 'Start New Topic'
    fill_in 'Title', with: ''
    fill_in 'Text', with: @topic1.text
    fill_in 'Link', with: @topic1.link
    click_button 'Submit'

    assert page.has_content?('error')
    assert_equal before_count, Topic.count
  end
end
