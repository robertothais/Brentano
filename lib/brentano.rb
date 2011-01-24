require 'brentano/rails'

module Brentano
  
  autoload :Presenter, 'brentano/presenter'
  autoload :Query, 'brentano/query'
  
  mattr_accessor :query_limit
  @@query_limit = 20
  
end
