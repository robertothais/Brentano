require 'hashie'

module Brentano
  class Presenter

    class_attribute :sizes

    attr_reader :subject, :options, :collection, :maximum_size

    alias_method :proxy_respond_to?, :respond_to?

    def initialize(subject, options = {}, &blk)
      @subject = subject
      @options = Hashie::Mash.new(options)
      yield self if block_given?
      finish
    end

    def finish(&blk)
      @collection = Brentano::Query.finish relation, options.dup, &blk
    end

    def maximum_size=(size)
      @maximum_size = if size.is_a? Fixnum
       size
      else
        sizes[size]
      end
      options.limit = @maximum_size
    end

    def respond_to?(*args)
      proxy_respond_to?(args[0]) || @collection.respond_to?(args[0])
    end

    def method_missing(name, *args, &blk)
      if @collection.respond_to? name
        result = @collection.send(name, *args, &blk)
        if result.is_a? ActiveRecord::Relation
          self.dup.tap do |copy|
            copy.instance_eval { @collection = result }
          end
        else
          result
        end
      else
        super
      end
    end

    def as_json(*args)
      @collection.as_json(*args)
    end

    def to_sql
      @collection.to_sql
    end

  end
end