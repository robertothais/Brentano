require 'brentano/rails'

module Brentano
  
  autoload :Presenter, 'brentano/presenter'
  autoload :Query, 'brentano/query'
  
  mattr_accessor :query_limit
  @@query_limit = 20
  
  mattr_accessor :qualifier_key
  @@qualifier_key = :options
  
  mattr_accessor :presenter_module
  @@presenter_module = "Presenters"  
  
end
