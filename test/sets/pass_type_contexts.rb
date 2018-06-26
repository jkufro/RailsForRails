module Contexts
  module PassTypeContexts
    def create_pass_types
      @fun_pass = FactoryBot.create(:pass_type)
      @annual_pass = FactoryBot.create(:pass_type, name: 'Annual Pass', description: 'Pay each month and get great park benefits')
    end

    def delete_pass_types
      @fun_pass.delete
      @annual_pass.delete
    end
  end
end
