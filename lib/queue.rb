require "net/https"
require "json"
require "CSV"
require "terminal-table"
require "./lib/attendee_repository.rb"
require "erb"

class Queue
  attr_reader :attendee_repository

  def initialize
    @attendee_repository = AttendeeRepository.new
  end

  def load(path = "./test/fixtures/event_attendees.csv")
    @attendee_repository.load(path)
  end

  def count
    @attendee_repository.count
  end

  def find (attribute, value)
    @attendee_repository.find_all_by(attribute, value)
  end

  def clear
    @attendee_repository.clear
  end

  def district
    api_key = "e179a6973728c4dd3fb1204283aaccb5"
    if  count > 0 && count < 11
      @attendee_repository.all_attendeez_with_attribute.each do |attendee|
        uri = URI("http://congress.api.sunlightfoundation.com/districts/locate?zip=#{attendee.zipcode}&apikey=#{api_key}")
        district = (JSON.load(Net::HTTP.get(uri))["results"].first)
        attendee.district = district["district"]
      end
    else
      "Your count is to high, we aren't going to ping them that much"
    end
  end

  def row_maker
    rows = @attendee_repository.all_attendeez_with_attribute.map do |attendee|
      ["#{attendee.registration_date}", "#{attendee.first_name}", "#{attendee.last_name}", "#{attendee.email_address}", "#{attendee.home_phone}", "#{attendee.street_address}", "#{attendee.city}", "#{attendee.state}", "#{attendee.zipcode}", "#{attendee.district}"]
    end
  end

  def header_maker
    headers = @attendee_repository.all_attendeez.first.instance_variables
    formatted_headers = headers.map do |header|
      header.to_s.upcase.gsub(/[^"A-Z"]/," ")
    end
  end

  def print
    unless @attendee_repository.count == 0
      table = Terminal::Table.new :headings => header_maker, :rows => row_maker
      puts table
    else
      "Sorry the Queue is Empty, Nothing to print"
    end
  end

  def print_by(attribute)
    unless @attendee_repository.count == 0 or !attribute_exists?(attribute)
      @attendee_repository.sort_by(attribute)
      print
    else
      "Sorry the Queue is Empty, Nothing to print"
    end
  end


  def attribute_exists?(attribute)
    all_attributes = @attendee_repository.all_attendeez.first.instance_variables.map { |a| a[1..-1].to_s.downcase}
    all_attributes.include?(attribute.downcase)
  end

  def write_to_html(file_name)
    thing = html_prepper
    filename = "#{file_name}.html"
    File.open(filename,'w') do |file|
      file.puts thing
    end
    "puts html written"
  end

  def html_prepper
    html_template = File.read "html-template.erb"
    erb_template = ERB.new html_template
    erb_template.result(binding)
  end

  def save_to(path)
    CSV.open("#{path}", "w") do |csv|
      headers = ["regdate", "first_name","last_name", "email_address", "homephone", "street", "city", "state", "zipcode", "district"]
      csv << headers
      rows = @attendee_repository.all_attendeez_with_attribute.map do |attendee|
        csv << ["#{attendee.registration_date}", "#{attendee.first_name}", "#{attendee.last_name}", "#{attendee.email_address}", "#{attendee.home_phone}", "#{attendee.street_address}", "#{attendee.city}", "#{attendee.state}", "#{attendee.zipcode}", "#{attendee.district}"]
      end
    end
  end





end
