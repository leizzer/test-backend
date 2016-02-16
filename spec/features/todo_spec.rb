describe 'App' do
  context 'My TODO' do
    it 'should list my task', js: true do
      login_user

      expect(page).to have_content 'Clean room'
      expect(page).to_not have_content 'Task1' #other user task
    end

    it 'should create a new task and list it', js: true do
      login_user

      within '#todo-form' do
        fill_in 'description', with: 'Homework'
        select 'School', from: 'category'
        fill_in 'dueDate', with: '10-10-2045'

        find('button.taskAdd').click
      end

      expect(page).to have_content 'Homework'
    end

    it 'should toggle task complete/uncomplete', js: true do
      login_user

      within 'ul.taskList' do
        expect(page).to have_xpath '//*[contains(@class, "complete-false")]'

        find('span', text: 'Clean room').click
        expect(page).to have_xpath '//*[contains(@class, "complete-true")]'

        find('span', text: 'Clean room').click

        wait_for_ajax
        expect(page).to_not have_xpath '//*[contains(@class, "complete-true")]'
      end
    end

    it 'should delete task', js: true do
      login_user

      within 'ul.taskList' do
        all('input.taskCheckbox').each do |ch|
          ch.set true
        end
      end

      find('button.taskDelete').click

      wait_for_ajax
      expect(page).to_not have_css('.taskItem')
    end
  end

  context 'other user TODO' do
    it "should list other user's tasks", js: true do
      login_user

      click_link 'Bar'

      expect(page).to have_content 'Task1'
      expect(page).to have_content 'Task2'
      expect(page).to_not have_content 'Clean room' #other user task
    end

    it 'should not let me mark a task as done', js: true do
      login_user

      click_link 'Bar'

      within 'ul.taskList' do
        expect(page).to have_xpath '//*[contains(@class, "complete-false")]'

        find('span', text: 'Task1').click
        expect(page).to have_xpath '//*[contains(@class, "complete-false")]'
      end
    end

    it 'should not let me delete a task', js: true do
      login_user

      click_link 'Bar'

      expect(page).to_not have_css('button.taskDelete')
    end
  end
end
 
