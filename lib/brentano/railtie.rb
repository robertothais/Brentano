require File.join(File.dirname(__FILE__), '..', '..', 'rails', 'helpers')

module Brentano
  class Railtie < ::Rails::Railtie

    initializer 'brentano.extend_action_controller' do
      ActiveSupport.on_load(:action_controller) do
        self.send :include, Brentano::Helpers
      end
    end

  end
end