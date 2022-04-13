module CoreApi
  module Users
    class ListAll < BaseService

      def self.call
        users = User.all
        body = users.empty? ? no_users_response : users
        { users: body }
      end

      private

      def self.no_users_response
        "There is no users.Go ahead and create one!"
      end

    end
  end
end