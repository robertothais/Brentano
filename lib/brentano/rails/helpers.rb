module Brentano
  module Helpers
    
    def presenter(klass_name, subject, options = params[:options], &blk) 
      klass = "Presenters::#{klass_name.to_s.camelcase}".constantize
      klass.new subject, options, &blk
    end
  
  end
end