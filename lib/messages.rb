module Messages


  def help_list

    "
    Welcome to Event-Reporter\n
    The avaible commands are as follows:
    load <file_name.csv>
    find <attribute> <criteria>
    queue count
    queue clear
    queue district
    queue print
    queue print by <attribute>
    queue export html <filename.csv>
    queue save to <filename.csv>
    help <command> will give you more detailed instructions"
  end

  def help_load
    "Typing 'help load <file_name>.csv' will allow you custom load
    your own CSV files into the program. Otherwise it will default
    to the event_attendees.csv provided in the in the root of the file."
  end

  def help_find
    "Typing 'help find <attribute> <criteria>' will populate your que
    for you. Attribute is refering to category you'd like to select
    build your que based on and the criteria is the value you want
    it to have an example would be as follow:
    'find first_name Mary' would return a list of all attendees
    with the first name 'mary', not the criteria is case insentive.

    The default attributes that event attendees have are:
    registration_date,
    first_name,
    last_name,
    email_address,
    home_phone,
    street_address,
    city,
    state,
    zipcode

    Just to reiterate Typing 'find state VA' would return all
    the attendees that live in that state."
  end

  def help_count
    "Typing 'queue count' will return the amount of people in
    'queue' your que is empty on until you use the find command
    and will be reset every time you do a new fnd with new criteria."
  end

  def help_clear
    "Typing 'que clear' will reset your queue."
  end

  def help_district
    "If there are less than 10 entries in the queue,
    this command will use the Sunlight API to get
    Congressional District information for each entry."
  end

  def help_print
    "Print out a tab-delimited data table with a header row"
  end

  def help_print_by_attribute
    "Print the data table sorted by the specified attribute like zipcode."
  end

  def help_export_html
    "Export the current queue to the specified filename as a valid HTML file.
    The file should use tables and include the data for all of the expected information."
  end

  def help_save_to_csv
    "Export the current queue to the specified filename as a CSV.
    The file should should include data and headers for last name,
    first name, email, zipcode, city, state, address, and phone number"

  end

end
