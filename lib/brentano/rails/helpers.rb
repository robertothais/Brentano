module Brentano
  module Helpers
    
    def presenter(klass_name, profile = nil, options = params[:options], &blk) 
      if profile.blank? && user_signed_in?
        profile = current_profile
      end
      klass = "Presenters::#{klass_name.to_s.camelcase}".constantize
      klass.new profile, options, &blk
    end
  
  end
end