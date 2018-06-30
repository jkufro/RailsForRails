module Contexts
  module VisitContexts
    def create_visits
      @justin_visit = FactoryBot.create(:visit, park_pass: @justin_fun_pass)
      @ashley_visit = FactoryBot.create(:visit, park_pass: @ashley_fun_pass)
      @gail_visit = FactoryBot.create(:visit, park_pass: @gail_fun_pass)
    end

    def delete_visits
      @justin_visit.delete
      @ashley_visit.delete
      @gail_visit.delete
    end
  end
end
