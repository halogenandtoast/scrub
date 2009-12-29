module Scrub
  class Scrubber
    def initialize(&block)
      config(&block) if block_given?
    end
  
    def config
      @config = Scrub::Config.new
      yield @config
    end
  
    def crawl(data, splitter = /\n/)
      lines = data.split(splitter)
      while(line = lines.shift)
        line.strip!
        @config.matchers.each do |matcher, prok|
          prok.call(line) if line =~ matcher
        end
        @config.between_matchers.each do |matcher, options|
          if line =~ matcher
            end_matcher, prok, conditions = options
            next_line = nil
            while(next_line = lines.shift) && (next_line !~ end_matcher)
              prok.call(next_line) if next_line =~ conditions[:when]
            end
          end
        end
      end
    end
  end
  
  class Config
    attr_accessor :matchers, :between_matchers
    def initialize
      @matchers, @between_matchers = {}, {}
    end
    def when matcher, &block
      @matchers[matcher] = block
    end
    def between beginning_matcher, end_matcher, options = {}, &block
      @between_matchers[beginning_matcher] = [end_matcher, block, {:when => /.*?/}.merge(options)]
    end
  end
end
