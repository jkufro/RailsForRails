module Contexts
  module UserContexts
    def create_users
      @justin = FactoryBot.create(:user, username: '', role: 'visitor')
      @tyler = FactoryBot.create(:user, username: '', role: 'visitor')
    end

    def delete_users
      @justin.delete
      @tyler.delete
    end
  end
end
