# require "./test/test_helper"
require "./lib/attendee_repository.rb"
require "./lib/queue.rb"
require "./lib/repl"
class ReplTest < Minitest::Test

  def setup
    @repl = Repl.new
  end

  def test_it_initializes_a_queue
    assert_instance_of Queue, @repl.queue
  end

  

end
