require "./test/test_helper"
require "./lib/cleaner.rb"

class CleanerTest < Minitest::Test
  include Cleaner

def test_it_standadizes_zip_codes
  assert_equal "00000",standardize_zipcode()
  assert_equal "00001",standardize_zipcode(1)
  assert_equal "00012",standardize_zipcode(12)
  assert_equal "00123",standardize_zipcode(123)
  assert_equal "01234",standardize_zipcode(1234)
  assert_equal "12345",standardize_zipcode(12345)
end

def test_it_standadizes_phone_number
  assert_equal "0",standardize_phone_number("123456789")
  assert_equal "0",standardize_phone_number("0123456789")
  assert_equal "0",standardize_phone_number("notanumber")
  assert_equal "1234567890",standardize_phone_number("(123)456-7890")
  assert_equal "1234567890",standardize_phone_number("1(123)456-7890")
  # assert_equal 0,standardize_phone_number(1(123)456-7890)
end

def test_it_cleans_the_number
  assert_equal "1234567890",number_cleaner("(123)456-7890")
  assert_equal "1234"      ,number_cleaner("!!!!!!!!NO1234!!!")
end

def test_it_will_down_case_anything_even_if_its_nil
  assert_equal "0",   standardize_text(nil)
  assert_equal "asdf",standardize_text("ASDF")
  assert_equal "1234",standardize_text(1234)
  assert_equal "!!lk",standardize_text("!!lK")
end
end
