require_relative '../../forms/todo'

if RUBY_ENGINE == 'opal'
  class Element
    alias_native :datepicker
  end
end

class TestApp
  module Components
    class Todo < Wedge::Component
      name :todo

      on :ready do
        dom.find('#dueDate').datepicker(`{dateFormat: 'yy-mm-dd'}`)
      end

      on :submit, '#todo-form', form: :todo_form, key: :task  do |form, el|
        button = el.find '.taskAdd'
        button.prop "disabled", true

        begin
          if form.valid?
            create_task form.attributes do |res|
              if res[:success]
                add_task res[:task][:description], res[:task][:category], Date.parse(res[:task][:due_date]), res[:task][:read], res[:task][:id]
              else
                form.display_errors errors: res[:errors]
              end
            end
          else
            form.display_errors
          end
        ensure
          button.prop "disabled", false
        end
      end

      on :click, '.user-todo a' do |el, evt|
        evt.prevent_default

        result = list_tasks el.data(:id)

        dom.find('ul.taskList li').remove
        dom.find('form').remove

        result[:tasks].each do |task|
          add_task task[:description], task[:category], Date.parse(task[:due_date]), task[:read], task[:id]
        end

        dom.find('h4.user-name').html "User: #{el.html}"
        dom.find('input').remove
      end

      on :click, '.taskDelete' do |el, evt|
        evt.prevent_default

        button = el.find '.taskDelete'
        button.prop "disabled", true

        begin
          task_ids = dom.find("input:checked").map do |el|
            el.data 'id'
          end

          unless task_ids.empty?
            delete_tasks task_ids do |res|
              if res[:success]
                dom.find(".taskItem input:checkbox[data-id='" + task_ids.join("'],[data-id='") + "']").parent.remove
              end
            end
          end
        ensure
          button.prop "disabled", false
        end
      end

      on :click, '.taskItem' do |el, evt|
        read_task el.find('input').data('id') do |res|
          if res[:success]
            el.find('.description, .date').remove_class "complete-#{!res[:complete]}"
            el.find('.description, .date').add_class "complete-#{res[:complete]}"
          end
        end
      end

      on :click, '.taskItem input' do |el, evt|
        evt.stop_propagation
      end
    end
  end
end
