require "rubygems"
$:.unshift File.dirname(__FILE__) + "/../../lib"
$:.unshift File.dirname(__FILE__) + "/../"

require "test/unit"
require "logstash"
require "logstash/event"

class TestEvent < Test::Unit::TestCase
  def test_name(name)
    @typename = name
  end

  def test_sprintf
    test_name "sprintf"
    event = LogStash::Event.new
    event.type = @typename
    event.message = "hello world"
    event.source = "/home/foo"
    event["test"] = "test"

    ["@type", "@message", "@source", "test"].each do |name|
      assert_equal(event[name], event.sprintf("${#{name}}"))
    end
  end # def test_single_match
end # TestEvent
