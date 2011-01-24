require 'brentano/rails/helpers'

module Brentano
  class Railtie < ::Rails::Railtie
    
    initializer 'brentano.extend_action_contrller' do 
      ActiveSupport.on_load(:action_controller) do
        self.send :include, Brentano::Helpers
      end
    end
    
  end
end

