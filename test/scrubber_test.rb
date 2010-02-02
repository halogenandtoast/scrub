require 'test_helper'

class ScrubberTest < Test::Unit::TestCase
  def test_when
    scrubber = Scrubber.new do |scrubber|
      scrubber.when(/\d,\d,\d/) do |line|
        assert_equal '1,2,3', line.strip
      end
    end
    scrubber.scrub(File.read("fixtures/file1.txt"))
  end
  
  def test_when_with_var
    scrubber = Scrubber.new do |scrubber|
      scrubber.when(/([a-z]),[a-z],[a-z]/) do |line, var|
        assert_equal 'a,b,c', line.strip
        assert_equal 'a', var
      end
    end
    scrubber.scrub(File.read("fixtures/file1.txt"))
  end
  
  def test_between
    matches = ['a,b,c','1,2,3']
    scrubber = Scrubber.new do |scrubber|
      scrubber.between(/---/, /---/) do |line|
        assert_equal matches.shift, line.strip
      end
    end
    scrubber.scrub(File.read("fixtures/file2.txt"))
  end
  
  def test_between_with_when
    scrubber = Scrubber.new do |scrubber|
      scrubber.between(/---/, /---/, :when => /\d,\d,\d/) do |line|
        assert_equal '1,2,3', line.strip
      end
    end
    scrubber.scrub(File.read("fixtures/file2.txt"))
  end
  
  def test_between_with_when_and_var
    matches = ['a,b,c','1,2,3']
    var_matches = ['a', '1']
    scrubber = Scrubber.new do |scrubber|
      scrubber.between(/---/, /---/, :when => /(\w),\w,\w/) do |line, var|
        assert_equal matches.shift, line.strip
        assert_equal var_matches.shift, var
      end
    end
    scrubber.scrub(File.read("fixtures/file2.txt"))
  end
end