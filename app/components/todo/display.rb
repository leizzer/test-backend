class TestApp
  module Components
    module TodoDisplay
      def display
        display_tasks
        sidebar_list if server?

        dom
      end
    end
  end
end
