require 'commands/controller_response'

module AAA
  class MicahsController < ApplicationController
    skip_load_and_authorize_resource

    def create
      response = ::AAA::Commands::Micahs::Create.call(**(params.deep_symbolize_keys))
      handle_response(response)
    end

    def update
      response = ::AAA::Commands::Micahs::Update.call(**(params.deep_symbolize_keys))
      handle_response(response)
    end

    def destroy
      response = ::AAA::Commands::Micahs::Delete.call(**(params.deep_symbolize_keys))
      handle_response(response)
    end

    private
    include ::Commands::ControllerResponse
  end
end
