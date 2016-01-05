class TestApp
  module Forms
    class Register < Wedge::Plugins::Form
      name :register_form

      attr_accessor :username, :password, :email, :phone_number

      def validate
        assert_present :username
        assert_present :password
        assert_present :email
      end
    end
  end
end
