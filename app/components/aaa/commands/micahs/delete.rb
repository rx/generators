require 'commands/base'
require 'commands/validate_params'
module AAA
  module Commands
    module Micahs
      class Delete < ::Commands::Base
        attr_accessor :params
        private :params

        def initialize(**params)
          @params = validate_params(**params)
        end

        def call
          ActiveRecord::Base.transaction { success(data: delete_micah) }
        end

        private
        include ::Commands::ValidateParams

        def delete_micah
          micah = ::AAA::Micah.find_by!(id: params[:id])
          micah.destroy!(params)
          micah
        end

        def schema
          Dry::Validation.Form do
            required(:id).filled(:int?)
          end
        end
      end
    end
  end
end
