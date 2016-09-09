require "./lib/cleaner.rb"
class Attendee
  include Cleaner
  attr_reader :registration_date,
              :first_name,
              :last_name,
              :email_address,
              :home_phone,
              :street_address,
              :city,
              :state,
              :zipcode
attr_accessor :district

  def initialize(attributes)

    @registration_date = attributes[:regdate] # make a standardize_time
    @first_name        = standardize_text attributes[:first_name]
    @last_name         = standardize_text attributes[:last_name]
    @email_address     = standardize_text attributes[:email_address]
    @home_phone        = standardize_phone_number attributes[:homephone]
    @street_address    = standardize_text attributes[:street]
    @city              = standardize_text attributes[:city]
    @state             = standardize_text attributes[:state]
    @zipcode           = standardize_zipcode attributes[:zipcode]
    @district          = ""
  end
end
