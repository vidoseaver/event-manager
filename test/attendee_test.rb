require "./test/test_helper"
require "./lib/attendee.rb"

class AttendeeTest < Minitest::Test
  def setup
    @attendee = Attendee.new({
      :regdate      => "11/12/08 10:47",
      :first_name   => "Allison",
      :last_name    => "Nguyen",
      :email_address => "arannon@jumpstartlab.com",
      :homephone    => "6154385000",
      :street       => "3155 19th St NW",
      :city         => "Washington",
      :state        => "DC",
      :zipcode      => "20010"})
  end

def test_it_has_a_registration_date_and_time
  assert  @attendee.registration_date
  

  #show actual time?????
end
  def test_it_has_a_name_that_has_been_standardized
    assert_equal "allison", @attendee.first_name
  end

  def test_it_has_a_last_name_that_has_been_standardized
    assert_equal "nguyen", @attendee.last_name
  end

  def test_it_has_a_email_that_has_been_standardized
    assert_equal "arannon@jumpstartlab.com", @attendee.email_address
  end

  def test_it_has_a_phone_number_that_has_been_standardized
    assert_equal "6154385000", @attendee.home_phone
  end

  def test_it_has_a_street_address_thats_been_standardized
    assert_equal "3155 19th st nw", @attendee.street_address
  end

  def test_it_has_a_city_thats_been_standardized
    assert_equal "washington", @attendee.city
  end

  def test_it_has_a_city_thats_been_standardized
    assert_equal "dc", @attendee.state
  end

  def test_it_has_a_zipcode_thats_been_standardized
    assert_equal "20010", @attendee.zipcode
  end
end
