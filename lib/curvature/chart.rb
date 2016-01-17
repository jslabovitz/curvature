module Curvature

  class Chart

    attr_accessor :name
    attr_accessor :width
    attr_accessor :height
    attr_accessor :x_range
    attr_accessor :y_range
    attr_accessor :curves

    def initialize(params={})
      @curves = []
      {
        width: 500,
        height: 500,
      }.merge(params).each { |k, v| send("#{k}=", v) }
    end

    def <<(curve)
      curve.chart = self
      @curves << curve
    end

    def scaled_point(x, y)
      [
        @width * ((x - @x_range.min) / (@x_range.max - @x_range.min)),
        @height * ((y - @y_range.min) / (@y_range.max - @y_range.min)),
      ]
    end

    def to_html
      xml = Builder::XmlMarkup.new(indent: 2)
      xml.div(class: 'chart') do
        xml.h2(@name) if @name
        xml.svg(xmlns: 'http://www.w3.org/2000/svg', version: '1.1', width: @width, height: @height) do
          xml.g(width: @width, height: @height, transform: "translate(0,#{@height}) scale(1,-1)") do
            # draw border
            xml.rect(x: 0, y: 0, width: @width, height: @height, fill: 'none', :'stroke-width' => 1, stroke: 'blue')

            # draw linear line
            xml.line(x1: 0, y1: 0, x2: @width, y2: @height, :'stroke-width' => 0.5, stroke: 'blue')

            # draw curves
            @curves.each do |curve|
              xml << curve.to_html
            end
          end
        end
      end
      xml.target!
    end

  end

end