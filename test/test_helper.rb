require 'test/unit'
require 'rubygems'
require 'shoulda'

require File.dirname(__FILE__) + '/../lib/rsaml'
include RSAML
include RSAML::Statement

class Test::Unit::TestCase
  def date_match
    '\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z'
  end
  def uuid_match
    '[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}'
  end
end