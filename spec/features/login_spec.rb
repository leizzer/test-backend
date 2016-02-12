describe 'App' do
  context 'login in' do
    it 'should show Login page as root', js: true do
      visit '/'
      expect(page).to have_content 'ACD - Test - Login'
      expect(page).to_not have_content 'Create an account'
    end

    it 'should toggle to create account', js: true do
      visit '/'
      find('div.toggle').click
      expect(page).to have_content 'Create an account'
    end

    it 'shuold create an account', js: true do
      users_count = User.all.count

      visit '/'
      find('div.toggle').click

      within('#registration-form') do
        fill_in 'Username', with: 'Chuck'
        fill_in 'Password', with: '123456789'
        fill_in 'Email Address', with: 'email@mail.com'
        fill_in 'Phone Number', with: '(123)456-7890'

        click_button('Register')
      end

      expect(page).to have_content 'Login to your account'
      expect(User.all.count).to eql(users_count + 1)
    end

    it 'should let user sign in and sign out', js: true do
      visit '/'

      within('#login-form') do
        fill_in 'Username', with: 'Foo'
        fill_in 'Password', with: '123456789'

        click_button('Login')
      end

      expect(page).to have_content 'ADD TASK'

      click_link('(sign out)')

      expect(page).to have_content 'Login to your account'

      visit '/'
      expect(page).to have_content 'Login to your account'
    end
  end
end
