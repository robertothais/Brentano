require 'brentano/railtie'

module Brentano

  autoload :Presenter, 'brentano/presenter'
  autoload :Query, 'brentano/query'

  mattr_accessor :qualifier_key
  @@qualifier_key = :options

  mattr_accessor :presenter_module
  @@presenter_module = "Presenters"
  
  mattr_accessor :allowed_methods
  @@allowed_methods = [ :limit, :offset ]
  
  mattr_accessor :allowed_scopes
  @@allowed_scopes = [ ]
  
  mattr_accessor :absolute_limit
  @@absolute_limit = 20

  def config
    yield self
  end

end