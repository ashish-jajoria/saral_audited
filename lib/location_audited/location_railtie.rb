# frozen_string_literal: true

module LocationAudited
  class Railtie < Rails::Railtie
    initializer "location_audited.sweeper" do
      ActiveSupport.on_load(:action_controller) do
        if defined?(ActionController::Base)
          ActionController::Base.around_action LocationAudited::LocationSweeper.new
        end
        if defined?(ActionController::API)
          ActionController::API.around_action LocationAudited::LocationSweeper.new
        end
      end
    end
  end
end
