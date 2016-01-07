class TestApp
  module Components
    module TodoServer

      def list_tasks user_id = nil
        user = user_id ? User.find(id: user_id) : current_user
        {success: true, tasks: user.tasks}
      end

      def display_tasks user_id = nil
        list_tasks(user_id)[:tasks].each do |task|
          add_task task[:description], task[:category], task[:due_date], task[:read], task[:id]
        end
      end

      def create_task task
        ap task

        task[:user_id] = current_user.id
        new_task = Task.new task

        if new_task.valid?
          new_task.save
          { success: true, task: new_task }
        else
          ap new_task.errors
          { success: false,
            errors: new_task.errors
          }
        end
      end

      def delete_tasks tasks
        ap tasks

        if Task.where(id: tasks, user_id: current_user.id).destroy > 0
          { success: true }
        end
      end

      def read_task task_id
        ap task_id

        task = Task.find id: task_id, user_id: current_user.id

        if task
          task.update read: !task.read

          { success: true, complete: task.read }
        else
          { success: true, error: "Task doesn't exist or you don't have access" }
        end
      end
    end
  end
end
