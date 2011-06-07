# A lightweight wrapper class over ActiveRecord::Relation which allows certain
# query parameters to be supplied as a hash. Good for automating and securing
# queries from request params
module Brentano
  class Query

    attr_writer :allowed_methods
    attr_writer :allowed_scopes
    attr_writer :absolute_limit

    def self.finish(relation, options)
      obj = self.new relation
      yield obj if block_given?
      obj.apply options
    end

    def apply(options)
      supplied_scopes = Array.wrap(options[:scopes] || options[:scope])
      supplied_scopes << "by_#{options[:by]}" if options[:by].present?
      supplied_scopes.map!(&:to_sym)
      scopes = allowed_scopes & supplied_scopes
      scoped_relation = scopes.inject(@relation) { |r, s| r.send(s) }
      if absolute_limit.present?
        options[:limit] ||= absolute_limit
        options[:limit] = [ options[:limit].to_i, absolute_limit ].min
      end
      options[:offset] &&= options[:offset].to_i
      options[:limit] &&= options[:limit].to_i
      allowed_methods.inject(scoped_relation) do |r, m|
        r = r.send(m, options[m]) if options[m].present?
        r
      end
    end
    
    def allowed_methods
      @allowed_methods ||= Brentano.allowed_methods.dup
    end
    
    def allowed_scopes 
      @allowed_scopes ||= Brentano.allowed_scopes.dup
    end
    
    def absolute_limit
      @absolute_limit ||= Brentano.absolute_limit
    end

    def initialize(relation)
      @relation = relation
    end

  end
end