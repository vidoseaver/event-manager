require "./test/test_helper"
require "./lib/attendee_repository.rb"
require "./lib/attendee.rb"
require "./lib/queue.rb"


class QueueTest < Minitest::Test

  def setup
    @queue = Queue.new
  end

  def test_it_exists
    assert_instance_of Queue, @queue
  end

  def test_it_initializes_with_attendee_repo
    assert_instance_of AttendeeRepository , @queue.attendee_repository
  end

  def test_it_can_load_a_csv
    assert @queue.attendee_repository.all_attendeez.empty?

    @queue.load("./test/fixtures/nineteen_event_attendees.csv")
    assert_instance_of Attendee, @queue.attendee_repository.all_attendeez.first

  end

  def test_it_can_find_all_attendees_by_attribute
    assert_equal 0, @queue.count

    @queue.load("./test/fixtures/nineteen_event_attendees.csv")
    @queue.find("first_Name","shannon")

    assert_equal 2, @queue.count
    assert @queue.attendee_repository.all_attendeez_with_attribute.all? {|attendee| attendee.first_name == "shannon"}
    assert_equal "warner", @queue.attendee_repository.all_attendeez_with_attribute.first.last_name
    assert_equal "davis", @queue.attendee_repository.all_attendeez_with_attribute.last.last_name
  end

  def test_it_can_clear_the_que
    @queue.load("./test/fixtures/nineteen_event_attendees.csv")
    @queue.find("first_name","shannon")
    assert_equal 2, @queue.count

    @queue.clear
    assert_equal 0, @queue.count
  end

  def test_it_can_load_districts
    @queue.load("./test/fixtures/nineteen_event_attendees.csv")
    @queue.find("first_name","shannon")

    @queue.district

    assert @queue.attendee_repository.all_attendeez_with_attribute.all? do |attendee|
      attendee.district = "2"
    end
  end

  def test_row_maker_makes_rows_for_table_and_csv
    @queue.load("./test/fixtures/nineteen_event_attendees.csv")
    @queue.find("first_name","shannon")
    row = ["11/17/08 19:41", "shannon", "warner", "gkjordandc@jumpstartlab.com", "6033053000", "186 crooked s road", "lyndeborough", "nh", "03082", ""]

    assert_equal row, @queue.row_maker.first
  end

  def test_header_maker_makes_the_header_for_table_and_csv
    @queue.load("./test/fixtures/nineteen_event_attendees.csv")
    @queue.find("first_name","shannon")
    header = [" REGISTRATION DATE", " FIRST NAME", " LAST NAME", " EMAIL ADDRESS", " HOME PHONE", " STREET ADDRESS", " CITY", " STATE", " ZIPCODE", " DISTRICT"]

    assert_equal header, @queue.header_maker
  end

  def test_it_prints_a_pretty_terminal_table_that_dynamically_adjusts
    skip
    @queue.load("./test/fixtures/nineteen_event_attendees.csv")
    @queue.find("first_name","shannon")
    assertion ="+--------------------+-------------+------------+-----------------------------+-------------+-------------------------------+--------------+--------+----------+-----------+
                |  REGISTRATION DATE |  FIRST NAME |  LAST NAME |  EMAIL ADDRESS              |  HOME PHONE |  STREET ADDRESS               |  CITY        |  STATE |  ZIPCODE |  DISTRICT |
                +--------------------+-------------+------------+-----------------------------+-------------+-------------------------------+--------------+--------+----------+-----------+
                | 11/17/08 19:41     | shannon     | warner     | gkjordandc@jumpstartlab.com | 6033053000  | 186 crooked s road            | lyndeborough | nh     | 03082    |           |
                | 11/19/08 21:56     | shannon     | davis      | ltb3@jumpstartlab.com       | 5303557000  | campion 1108 914 e. jefferson | seattle      | wa     | 98122    |           |
                +--------------------+-------------+------------+-----------------------------+-------------+-------------------------------+--------------+--------+----------+-----------+"
    assert_equal assertion, @queue.print
  end

  def test_empty_count_results_in_sad_message
    assert_equal "Sorry the Queue is Empty, Nothing to print", @queue.print
  end

  def test_it_can_print_a_list_sorted_by_an_attribute
    skip
    @queue.load("./test/fixtures/nineteen_event_attendees.csv")
    @queue.find("first_name","shannon")
    assert_equal 2, @queue.attendee_repository.all_attendeez_with_attribute.count
    assertion ="+--------------------+-------------+------------+-----------------------------+-------------+-------------------------------+--------------+--------+----------+-----------+
                |  REGISTRATION DATE |  FIRST NAME |  LAST NAME |  EMAIL ADDRESS              |  HOME PHONE |  STREET ADDRESS               |  CITY        |  STATE |  ZIPCODE |  DISTRICT |
                +--------------------+-------------+------------+-----------------------------+-------------+-------------------------------+--------------+--------+----------+-----------+
                | 11/17/08 19:41     | shannon     | warner     | gkjordandc@jumpstartlab.com | 6033053000  | 186 crooked s road            | lyndeborough | nh     | 03082    |           |
                | 11/19/08 21:56     | shannon     | davis      | ltb3@jumpstartlab.com       | 5303557000  | campion 1108 914 e. jefferson | seattle      | wa     | 98122    |           |
                +--------------------+-------------+------------+-----------------------------+-------------+-------------------------------+--------------+--------+----------+-----------+"
    assert_equal 1, @queue.print_by("last_name")
  end

  def test_it_can_write_to_an_html_file
    @queue.load("./test/fixtures/nineteen_event_attendees.csv")
    @queue.find("first_name","shannon")
    assert_equal "puts html written", @queue.write_to_html("test")
  end
end
