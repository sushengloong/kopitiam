require 'test_helper'

class AuthenticationIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    @user1 = User.create email: 'abc@test.com', password: '123456', password_confirmation: '123456'
  end

  def teardown
    User.destroy_all
  end

  test 'user logs in with valid login credentials' do
    visit root_path
    refute page.has_content?('Logout')
    fill_in 'Email', with: @user1.email
    fill_in 'Password', with: @user1.password
    click_button 'Login'
    assert page.has_content?(@user1.email)
    assert page.has_content?('Logout')
  end
end
