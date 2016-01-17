module Curvature

  class Sample

    attr_accessor :label
    attr_accessor :input
    attr_accessor :output
    attr_accessor :attributes

    def initialize(params={})
      {
      }.merge(params).each { |k, v| send("#{k}=", v) }
    end

  end

end