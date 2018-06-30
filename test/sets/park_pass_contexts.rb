module Contexts
  module ParkPassContexts
    def create_park_passes
      @justin_fun_pass = FactoryBot.create(:park_pass, card_expiration: Date.new(Date.today.year + 1,12,31), user: @justin, pass_type: @fun_pass)
      @ashley_fun_pass = FactoryBot.create(:park_pass, first_name: 'Ashley', last_name: 'Haenig', card_expiration: Date.new(Date.today.year + 1,12,31), user: @justin, pass_type: @fun_pass)
      @tyler_annual_pass = FactoryBot.create(:park_pass, first_name: 'Tyler', user: @tyler, pass_type: @annual_pass)
      @gail_fun_pass = FactoryBot.create(:park_pass, first_name: 'Gail', last_name: 'Kufro', user: @gail, pass_type: @fun_pass)
      @joe_fun_pass = FactoryBot.create(:park_pass, first_name: 'Joe', last_name: 'Kufro', user: @gail, pass_type: @fun_pass)
    end

    def delete_park_passes
      @justin_fun_pass.delete
      @ashley_fun_pass.delete
      @tyler_annual_pass.delete
    end
  end
end
