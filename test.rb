require_relative 'parser.rb'
require "test/unit"

class TestParser < Test::Unit::TestCase
  def test_args_present
    args = []
    assert_raise( RuntimeError ) { Parser.new(args) }
  end

  def test_extra_args_found
    args = %w[one two]
    assert_raise( RuntimeError ) { Parser.new(args) }
  end

  def test_wrong_extension_found
    args = %w[webserver.txt]
    assert_raise( RuntimeError ) { Parser.new(args) }
  end

  def test_valid_calculations
    expected_hash = {
      '/contact' => 2,
      '/index' => 1,
    }
    webpages_views = Parser.new(['test.log']).get_webpages_views

    assert_equal(expected_hash, webpages_views )
  end

  def test_wrong_calculations
    expected_hash = {
      '/contact' => 1,
      '/index' => 1,
    }
    webpages_views = Parser.new(['test.log']).get_webpages_views

    assert_not_equal(expected_hash, webpages_views )
  end
end
