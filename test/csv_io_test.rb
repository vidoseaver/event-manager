require "./test/test_helper"
require "./lib/csv_io.rb"

class CsvIOTest < Minitest::Test
  include CsvIO

  def test_it_can_load_a_csv
    path = "./test/fixtures/nineteen_event_attendees.csv"
    assert_instance_of CSV , loader(path)
  end

  def test_it_defaults_to_the_full_event_attendees_file_when_none_is_provided
    assert_instance_of CSV, loader
    #another test proving its the long one...
  end

  def test_it_can_write_csvs
    path = "./test/fixtures/nineteen_event_attendees.csv"
    first_csv = loader(path)

    assert_instance_of CSV, write_new_csv(first_csv)
  end
end
