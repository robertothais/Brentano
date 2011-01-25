module Brentano
  module Helpers
    
    def presenter(klass_name, subject, options = params[Brentano.qualifier_key], &blk) 
      klass = "#{Brentano.presenter_module}::#{klass_name.to_s.camelcase}".constantize
      klass.new subject, options, &blk
    end
  
  end
end