module Curvature

  class Curve

    attr_accessor :name
    attr_accessor :samples
    attr_accessor :chart

    def initialize(params={})
      @samples = []
      {
      }.merge(params).each { |k, v| send("#{k}=", v) }
    end

    def <<(sample)
      @samples << sample
    end

    def value_for(input)
      unless @spliner
        @spliner = Spliner::Spliner.new(
          @samples.map(&:input),
          @samples.map(&:output),
        )
      end
      @spliner[input] or raise "Can't find output for input #{input.inspect} on curve #{@name.inspect}"
    end

    def print
      puts @name
      @samples.each do |sample|
        puts "\t%2s: %2.2f => %2.2f" % [sample.label, sample.input, sample.output]
      end
      puts
    end

    DefaultSampleAttributes = {
      stroke: 'none',
      fill: 'black',
    }

    def to_html
      xml = Builder::XmlMarkup.new(indent: 2)

      # draw interpolated curve
      xml.g(fill: 'none', stroke: 'green', :'stroke-width' => 0.5) do
        points = @chart.x_range.step(1.0 / @chart.width).map do |input|
          @chart.scaled_point(input, value_for(input))
        end
        xml.polyline(points: points.map { |pt| pt.join(',') }.join(' '))
      end

      # draw individual samples
      @samples.each do |sample|
        cx, cy = @chart.scaled_point(sample.input, sample.output)
        attributes = DefaultSampleAttributes.merge(
          title: sample.label,
          cx: cx,
          cy: cy,
          r: 3,
        ).merge(sample.attributes || {})
        xml.circle(attributes)
      end

      xml.target!
    end

  end

end