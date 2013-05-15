require 'test_helper'

class TopicsIntegrationTest < ActionDispatch::IntegrationTest
  test 'should display all topics' do
    topic1 = Topic.create title: "Rails 4 has been released!", text: "I love RoR!", link: "http://rubyonrails.org/"
    topic2 = Topic.create title: "Ruby 2 has been released!", text: "I love RoR!", link: "http://ruby-lang.org/"
    
    visit root_path
    assert page.has_content?(topic1.title)
    assert page.has_content?(topic2.title)
  end
end
