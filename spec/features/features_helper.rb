module FeaturesHelper
  def login_user
    visit '/'

    within('#login-form') do
      fill_in 'Username', with: 'Foo'
      fill_in 'Password', with: '123456789'

      click_button 'Login'
    end
  end
end
