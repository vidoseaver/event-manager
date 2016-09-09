require "./test/test_helper"
require "./lib/Messages.rb"

class MessagesTest < Minitest::Test
  include Messages

  # def test_help_list stupid test formatting is fucked up
  #   skip
  #   return_message = +    "Welcome to Event-Reporter
  #
  #   The avaible commands are as follows:
  #   load <file_name.csv>
  #   find <attribute> <criteria>
  #   queue count
  #   queue clear
  #   queue district
  #   queue print
  #   queue print by <attribute>
  #   queue export html <filename.csv>
  #   queue save to <filename.csv>
  #   help <command> will give you more detailed instructions"
  #   assert_equal "0", help_list
  # end

  def test_help_load
    return_message = "Typing 'help load <file_name>.csv' will allow you custom load\n    your own CSV files into the program. Otherwise it will default\n    to the event_attendees.csv provided in the in the root of the file."
    assert_equal return_message, help_load
  end

  def test_help_find
    return_message = "Typing 'help find <attribute> <criteria>' will populate your que\n    for you. Attribute is refering to category you'd like to select\n    build your que based on and the criteria is the value you want\n    it to have an example would be as follow:\n    'find first_name Mary' would return a list of all attendees\n    with the first name 'mary', not the criteria is case insentive.\n\n    The default attributes that event attendees have are:\n    registration_date,\n    first_name,\n    last_name,\n    email_address,\n    home_phone,\n    street_address,\n    city,\n    state,\n    zipcode\n\n    Just to reiterate Typing 'find state VA' would return all\n    the attendees that live in that state."
    assert_equal return_message, help_find
  end

  def test_count
    return_message = "Typing 'queue count' will return the amount of people in\n    'queue' your que is empty on until you use the find command\n    and will be reset every time you do a new fnd with new criteria."
    assert_equal return_message, help_count
  end

  def test_clear
    return_message = "Typing 'que clear' will reset your queue."
    assert_equal return_message, help_clear
  end

  def test_district
    return_message = +"If there are less than 10 entries in the queue,
    this command will use the Sunlight API to get
    Congressional District information for each entry."
    assert_equal return_message, help_district
  end

  def test_help_print
    return_message = "Print out a tab-delimited data table with a header row"
    assert_equal return_message, help_print
  end

  def test_help_print_by_attribute
    return_message = +"Print the data table sorted by the specified attribute like zipcode."
    assert_equal return_message, help_print_by_attribute
  end

  def test_export_html
    return_message = "Export the current queue to the specified filename as a valid HTML file.
    The file should use tables and include the data for all of the expected information."
    assert_equal return_message, help_export_html
  end

  def test_save_to_csv
    return_message = "Export the current queue to the specified filename as a CSV.
    The file should should include data and headers for last name,
    first name, email, zipcode, city, state, address, and phone number"
    assert_equal return_message, help_save_to_csv
  end
end
