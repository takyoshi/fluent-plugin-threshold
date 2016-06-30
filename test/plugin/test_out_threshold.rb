require 'helper'

class SuppressOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    condition      ge
    threshold      5
    target_key     count
    add_tag_prefix th.
  ]

  CONFIG_STRING = %[
    condition      string
    threshold      error
    target_key     msg
    add_tag_prefix th.
  ]

  CONFIG_REGEXP = %[
    condition      regexp
    threshold      ^http.*
    target_key     msg
    add_tag_prefix th.
  ]

  def create_driver(conf = CONFIG, tag='test.info')
    Fluent::Test::OutputTestDriver.new(Fluent::ThresholdOutput, tag).configure(conf)
  end

  def test_emit
    d = create_driver

    time = Time.parse("2012-11-22 11:22:33 UTC").to_i
    d.run do
      d.emit({"id" => 1, "count" => 1, "uri" => "/v1*"}, time + 1)
      d.emit({"id" => 2, "count" => 2, "uri" => "/v2*"}, time + 2)
      d.emit({"id" => 3, "count" => 3, "uri" => "/v3*"}, time + 3)
      d.emit({"id" => 4, "count" => 4, "uri" => "/v4*"}, time + 4)
      d.emit({"id" => 5, "count" => 5, "uri" => "/v5*"}, time + 5)
      d.emit({"id" => 6, "count" => 6, "uri" => "/v6*"}, time + 6)
      d.emit({"id" => 7, "count" => 7, "uri" => "/v7*"}, time + 7)
      d.emit({"id" => 8, "count" => 8, "uri" => "/v8*"}, time + 8)
    end

    emits = d.emits
    assert_equal 4, emits.length
    assert_equal ["th.test.info", time + 5, {"id"=>5, "count"=>5, "uri"=>"/v5*"}], emits[0]
    assert_equal ["th.test.info", time + 6, {"id"=>6, "count"=>6, "uri"=>"/v6*"}], emits[1]
    assert_equal ["th.test.info", time + 7, {"id"=>7, "count"=>7, "uri"=>"/v7*"}], emits[2]
    assert_equal ["th.test.info", time + 8, {"id"=>8, "count"=>8, "uri"=>"/v8*"}], emits[3]
  end

  def test_emit_string
    d = create_driver CONFIG_STRING

    time = Time.parse("2012-11-22 11:22:33 UTC").to_i
    d.run do
      d.emit({"id" => 1, "msg" => "http://example.com/error", "uri" => "/v1*"}, time + 1)
      d.emit({"id" => 2, "msg" => "http://example.com/error", "uri" => "/v2*"}, time + 2)
      d.emit({"id" => 3, "msg" => "http://example.com/success", "uri" => "/v3*"}, time + 3)
      d.emit({"id" => 4, "msg" => "http://example.com/success", "uri" => "/v4*"}, time + 4)
      d.emit({"id" => 5, "msg" => "error", "uri" => "/v5*"}, time + 5)
      d.emit({"id" => 6, "msg" => "error", "uri" => "/v6*"}, time + 6)
      d.emit({"id" => 7, "msg" => "error", "uri" => "/v7*"}, time + 7)
      d.emit({"id" => 8, "msg" => "error", "uri" => "/v8*"}, time + 8)
    end

    emits = d.emits
    assert_equal 4, emits.length
    assert_equal ["th.test.info", time + 5, {"id"=>5, "msg"=>"error", "uri"=>"/v5*"}], emits[0]
    assert_equal ["th.test.info", time + 6, {"id"=>6, "msg"=>"error", "uri"=>"/v6*"}], emits[1]
    assert_equal ["th.test.info", time + 7, {"id"=>7, "msg"=>"error", "uri"=>"/v7*"}], emits[2]
    assert_equal ["th.test.info", time + 8, {"id"=>8, "msg"=>"error", "uri"=>"/v8*"}], emits[3]
  end

  def test_emit_regexp
    d = create_driver CONFIG_REGEXP

    time = Time.parse("2012-11-22 11:22:33 UTC").to_i
    d.run do
      d.emit({"id" => 1, "msg" => "http://example.com/error", "uri" => "/v1*"}, time + 1)
      d.emit({"id" => 2, "msg" => "http://example.com/error", "uri" => "/v2*"}, time + 2)
      d.emit({"id" => 3, "msg" => "http://example.com/success", "uri" => "/v3*"}, time + 3)
      d.emit({"id" => 4, "msg" => "http://example.com/success", "uri" => "/v4*"}, time + 4)
      d.emit({"id" => 5, "msg" => "error", "uri" => "/v5*"}, time + 5)
      d.emit({"id" => 6, "msg" => "error", "uri" => "/v6*"}, time + 6)
      d.emit({"id" => 7, "msg" => "error", "uri" => "/v7*"}, time + 7)
      d.emit({"id" => 8, "msg" => "error", "uri" => "/v8*"}, time + 8)
    end

    emits = d.emits
    assert_equal 4, emits.length
    assert_equal ["th.test.info", time + 1, {"id"=>1, "msg"=>"http://example.com/error", "uri"=>"/v1*"}], emits[0]
    assert_equal ["th.test.info", time + 2, {"id"=>2, "msg"=>"http://example.com/error", "uri"=>"/v2*"}], emits[1]
    assert_equal ["th.test.info", time + 3, {"id"=>3, "msg"=>"http://example.com/success", "uri"=>"/v3*"}], emits[2]
    assert_equal ["th.test.info", time + 4, {"id"=>4, "msg"=>"http://example.com/success", "uri"=>"/v4*"}], emits[3]
  end
end
