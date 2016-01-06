class TestApp
  module Forms
    class Todo < Wedge::Plugins::Form
      name :todo_form

      attr_accessor :description, :category, :due_date, :read

      def validate
        assert_present :description
        assert_present :category
        assert_present :due_date
      end
    end
  end
end
