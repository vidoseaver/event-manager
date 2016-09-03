require "./test/test_helper"
require "./lib/queue.rb"

class QueueTest < Minitest::Test

  def setup
    @queue = Queue.new
  end

  def test_it_exists
    assert_instance_of Queue, @queue
  end

  def test_it_can_load_a_csv
    path = "./test/fixtures/nineteen_event_attendees.csv"
    assert_instance_of CSV , @queue.load(path)
  end

  def test_it_defaults_to_the_full_event_attendees_file_when_none_is_provided
    assert_instance_of CSV, @queue.load
    #another test proving its the long one...
  end

end
