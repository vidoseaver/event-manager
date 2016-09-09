require "./test/test_helper"
require "./lib/attendee_repository.rb"

class AttendeeRepositoryTest < Minitest::Test

  def setup
    @attendee_repository = AttendeeRepository.new
  end

  def test_it_exists
    assert_instance_of AttendeeRepository, @attendee_repository
  end

  def test_it_can_load_a_csv
    path = "./test/fixtures/nineteen_event_attendees.csv"
    @attendee_repository.load(path)

    assert_equal 19, @attendee_repository.loader(path).count
    assert_equal 19, @attendee_repository.all_attendeez.count
  end

  def test_it_will_default_to_the_event_attendees_when_load_is_called
     @attendee_repository.load

    assert_instance_of Attendee, @attendee_repository.all_attendeez.first
    assert_equal 5175, @attendee_repository.all_attendeez.count
  end


  def test_it_can_make_and_store_attendees
    assert_equal [],  @attendee_repository.all_attendeez

   @attendee_repository.load

    assert_instance_of Attendee, @attendee_repository.all_attendeez.first
    assert_instance_of Attendee, @attendee_repository.all_attendeez.last
  end

  def test_it_can_find_all_attendees_by_attribute
    assert_equal [], @attendee_repository.all_attendeez_with_attribute

    @attendee_repository.load

    @attendee_repository.find_all_by("first_name","mary")


    assert_instance_of Attendee, @attendee_repository.all_attendeez_with_attribute.first
    assert_equal "mary", @attendee_repository.all_attendeez_with_attribute.first.first_name
    assert_equal "mary", @attendee_repository.all_attendeez_with_attribute.last.first_name

  end

  def test_attriubute_checker_returns_true_or_false

    path = "./test/fixtures/nineteen_event_attendees.csv"
    @attendee_repository.load(path)

    refute @attendee_repository.attribute_exists?("single")
    refute @attendee_repository.attribute_exists?("wierd")

    assert @attendee_repository.attribute_exists?("Registration_date")
    assert @attendee_repository.attribute_exists?("registration_Date")
    assert @attendee_repository.attribute_exists?("registration_date")
    assert @attendee_repository.attribute_exists?("first_name")
    assert @attendee_repository.attribute_exists?("last_name")
    assert @attendee_repository.attribute_exists?("email_address")
    assert @attendee_repository.attribute_exists?("home_phone")
    assert @attendee_repository.attribute_exists?("street_address")
    assert @attendee_repository.attribute_exists?("city")
    assert @attendee_repository.attribute_exists?("state")
    assert @attendee_repository.attribute_exists?("zipcode")
  end

  def test_count_returns_the_que_count
    assert_equal 0, @attendee_repository.count

    path = "./test/fixtures/nineteen_event_attendees.csv"
    @attendee_repository.load(path)
    @attendee_repository.find_all_by("first_Name", "allison")

    assert_equal 1, @attendee_repository.count
  end

  def test_it_can_clear_the_que
    assert_equal 0, @attendee_repository.count

    path = "./test/fixtures/nineteen_event_attendees.csv"
    @attendee_repository.load(path)
    @attendee_repository.find_all_by("first_Name", "allison")

    assert_equal 1, @attendee_repository.count

    @attendee_repository.clear

    assert_equal 0, @attendee_repository.count
  end

  def test_it_can_sort_by_attribute
    @attendee_repository.load
    @attendee_repository.find_all_by("state", "ca")
    unsorted_names = ["audrey", "eli", "meggie", "brant", "sherry", "kayla", "portia", "julie", "lydia", "natalie", "rachel", "gabe", "hannah", "brendan", "sam", "christie", "naani", "kate", "andrew", "kristen", "jane", "jaime", "eriel", "susie", "steve", "tess", "sarah", "patrick", "tara", "june", "cassie", "madeline", "amy", "stacy", "megan", "emilyn", "dominique", "evelina", "anne", "benjamin", "claire", "nadia", "sarah", "wendy", "eric", "melissa", "todd", "bradley", "sarah", "victoria", "robin", "ilya", "abram", "alissa", "leigh", "justine", "brady", "jennifer", "sara", "jessica", "erin", "kyle", "emily", "four", "jerry", "rueben", "heather", "mo", "megen", "omid", "rachel", "weston", "stephen", "morgan", "dan", "laura", "zachary", "walter", "guilia", "sarah", "margo", "luke", "ananda", "asia", "david", "trevor", "erin", "lauren", "emily", "elizabeth", "keith", "gideon", "jessica", "katie", "joanna", "robyn", "peter", "dyanna", "justine", "kaycee", "amanda", "juliette", "john", "andrew", "clare", "christine", "jennifer", "jennifer", "lena", "eleanor", "paul", "hungyen", "julia", "caitlin", "megan", "nathaniel", "andi", "jeff", "matt", "paulina", "leon", "lindsy", "amanda", "brian", "yiran", "daniel", "x", "jason", "sander", "chelsey", "rosina", "andrew", "sam", "basil", "jennifer", "gus", "brian", "carly", "pamela", "jim", "lisa", "victoria", "jon", "matt", "hector", "waqas", "rachel", "john gray", "taylor", "lauren", "kelli", "lacey", "laura", "katie", "timothy", "ave", "emily", "savannah", "michael", "arielle", "judy", "william", "becca", "brady", "annie", "elizabeth", "laurel", "tim", "jennifer", "armand", "brad", "tess", "todd", "john", "ainsley", "stephanie", "krista", "uruj", "jamie", "tiana", "lydia"]
    assert_equal unsorted_names, @attendee_repository.all_attendeez_with_attribute.map {|attendee| attendee.first_name}

    @attendee_repository.sort_by("first_name")

    sorted_names = ["abram", "ainsley", "alissa", "amanda", "amanda", "amy", "ananda", "andi", "andrew", "andrew", "andrew", "anne", "annie", "arielle", "armand", "asia", "audrey", "ave", "basil", "becca", "benjamin", "brad", "bradley", "brady", "brady", "brant", "brendan", "brian", "brian", "caitlin", "carly", "cassie", "chelsey", "christie", "christine", "claire", "clare", "dan", "daniel", "david", "dominique", "dyanna", "eleanor", "eli", "elizabeth", "elizabeth", "emily", "emily", "emily", "emilyn", "eric", "eriel", "erin", "erin", "evelina", "four", "gabe", "gideon", "guilia", "gus", "hannah", "heather", "hector", "hungyen", "ilya", "jaime", "jamie", "jane", "jason", "jeff", "jennifer", "jennifer", "jennifer", "jennifer", "jennifer", "jerry", "jessica", "jessica", "jim", "joanna", "john", "john", "john gray", "jon", "judy", "julia", "julie", "juliette", "june", "justine", "justine", "kate", "katie", "katie", "kaycee", "kayla", "keith", "kelli", "krista", "kristen", "kyle", "lacey", "laura", "laura", "laurel", "lauren", "lauren", "leigh", "lena", "leon", "lindsy", "lisa", "luke", "lydia", "lydia", "madeline", "margo", "matt", "matt", "megan", "megan", "megen", "meggie", "melissa", "michael", "mo", "morgan", "naani", "nadia", "natalie", "nathaniel", "omid", "pamela", "patrick", "paul", "paulina", "peter", "portia", "rachel", "rachel", "rachel", "robin", "robyn", "rosina", "rueben", "sam", "sam", "sander", "sara", "sarah", "sarah", "sarah", "sarah", "savannah", "sherry", "stacy", "stephanie", "stephen", "steve", "susie", "tara", "taylor", "tess", "tess", "tiana", "tim", "timothy", "todd", "todd", "trevor", "uruj", "victoria", "victoria", "walter", "waqas", "wendy", "weston", "william", "x", "yiran", "zachary"]
    assert_equal sorted_names, @attendee_repository.all_attendeez_with_attribute.map {|attendee| attendee.first_name}
  end


end
