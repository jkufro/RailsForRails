module Contexts
  module QuueueContexts
    def create_quueues
      @justin_montu = FactoryBot.create(:quueue, ride: @montu, visit: @justin_visit)
      @ashley_montu = FactoryBot.create(:quueue, ride: @montu, visit: @ashley_visit)
      @gail_cobras_curse = FactoryBot.create(:quueue, ride: @cobras_curse, visit: @gail_visit)
    end

    def delete_quueues
      @justin_montu.delete
      @ashley_montu.delete
      @gail_cobras_curse.delete
    end
  end
end
