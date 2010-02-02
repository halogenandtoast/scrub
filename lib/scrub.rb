require 'scrubber'
module Scrub
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
