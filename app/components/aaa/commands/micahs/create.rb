require 'commands/base'
require 'commands/validate_params'
module AAA
  module Commands
    module Micahs
      class Create < ::Commands::Base
        attr_accessor :params
        private :params

        def initialize(**params)
          @params = validate_params(**params)
        end

        def call
          ActiveRecord::Base.transaction { success(data: create_micah) }
        end

        private
        include ::Commands::ValidateParams

        def create_micah
          @micah = ::AAA::Micah.create!(params)
        end

        def schema
          Dry::Validation.Form do
            required(:name).filled(:str?)
          end
        end
      end
    end
  end
end
