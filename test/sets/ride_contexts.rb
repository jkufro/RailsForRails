module Contexts
  module RideContexts
    def create_rides
      @montu = FactoryBot.create(:ride)
      @sheikra = FactoryBot.create(:ride, ride_name: 'SheiKra', carts_on_track: 3, cart_occupancy: 24, ride_duration: 140, ride_description: 'No Floors!')
      @cobras_curse = FactoryBot.create(:ride, ride_name: "Cobra's Curse", carts_on_track: 8, cart_occupancy: 4, ride_duration: 180, ride_description: 'Spin!', min_height: 48)
      @scorpion = FactoryBot.create(:ride, ride_name: 'Scorpion', carts_on_track: 1, cart_occupancy: 16, ride_duration: 60, ride_description: 'Try out the loop!', min_height: 48, allow_queue: false)
      @cheetah_chase = FactoryBot.create(:ride, ride_name: 'Cheetah Chase', carts_on_track: 5, cart_occupancy: 4, ride_duration: 120, ride_description: '', min_height: 48, allow_queue: false, active: false)
    end

    def delete_rides
      @montu.delete
      @sheikra.delete
      @cobras_curse.delete
      @scorpion.delete
      @cheetah_chase.delete
    end
  end
end
