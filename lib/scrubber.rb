class Scrubber
  def initialize(&block)
    config(&block) if block_given?
  end

  def config
    @config = Scrub::Config.new
    yield @config
  end

  def scrub(data, splitter = /\n/)
    lines = data.split(splitter)
    while(line = lines.shift)
      line.strip!
      @config.matchers.each do |matcher, prok|
        if match = line.match(matcher)
          prok.call(line, *match.captures)
        end
      end
      @config.between_matchers.each do |matcher, options|
        if line =~ matcher
          end_matcher, prok, conditions = options
          next_line = nil
          while(next_line = lines.shift) && (next_line !~ end_matcher)
            if conditions[:when]
              if match = next_line.match(conditions[:when])
                prok.call(next_line, *match.captures) 
              end
            else
              prok.call(next_line) 
            end
          end
        end
      end
    end
  end
end