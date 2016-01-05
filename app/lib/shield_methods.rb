module ShieldMethods
  module InstanceMethods
    require 'shield'

    include Shield::Helpers

    def current_user
      authenticated User
    end
  end
end
