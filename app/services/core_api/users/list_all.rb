module CoreApi
  module Users
    class ListAll < BaseService

      def self.call
        users = User.all
        users.empty? ? no_users_response : users
      end

      private

      def no_users_response
        "There is no users.Go ahead and create one!"
      end

    end
  end
end