module Contexts
  module UserContexts
    def create_users
      @justin = FactoryBot.create(:user, username: 'jkufro', role: 'visitor')
      @tyler = FactoryBot.create(:user, username: 'tkufro', role: 'visitor')
      @gail = FactoryBot.create(:user, username: 'gkufro', role: 'visitor')
    end

    def delete_users
      @justin.delete
      @tyler.delete
      @gail.delete
    end
  end
end
