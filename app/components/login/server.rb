class TestApp
  module Components
    module LoginServer
      def login_user user
        if login User, user["username"], user["password"]
          { success: true }
        else
          { success: false, errors: {
            username: ['User or password incorrect'] }
          }
        end
      end

      def register_user user
        new_user = User.new user

        if new_user.valid?
          new_user.save
          { success: true }
        else
          { success: false, errors: new_user.errors}
        end
      end
    end
  end
end
