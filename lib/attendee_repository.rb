require "./lib/csv_io.rb"
require "./lib/attendee.rb"
require "pry"

class AttendeeRepository
  include CsvIO

  attr_reader :all_attendeez,
              :all_attendeez_with_attribute

  def initialize
    @all_attendeez = Array.new
    @all_attendeez_with_attribute = Array.new
  end

  def load(path = nil )
    @all_attendeez = Array.new
    path.nil? ? csv = loader : csv = loader(path)
    populate_with_all_attendees(csv)
  end

  def populate_with_all_attendees(csv)
    @all_attendeez = csv.map {|row| Attendee.new(row)}
    return
  end

  def find_all_by(attribute,criteria)
    clear
    attribute = attribute.downcase
    if attribute_exists? attribute
      @all_attendeez.each do |attendee|
        @all_attendeez_with_attribute << attendee if attendee.send(attribute.downcase) == criteria
      end
      return
    else
    "invalid attribute"
    end
  end

  def attribute_exists?(attribute)
    all_attributes = @all_attendeez.first.instance_variables.map { |a| a[1..-1].to_s.downcase}
    all_attributes.include?(attribute.downcase)
  end

  def count
    @all_attendeez_with_attribute.count
  end

  def clear
    @all_attendeez_with_attribute = Array.new
  end

  def sort_by(attribute)
    attribute = attribute.downcase
    if attribute_exists? attribute
      @all_attendeez_with_attribute = @all_attendeez_with_attribute.sort_by {|attendee| attendee.send(attribute)}
    else
    "invalid attribute"
    end
  end
end
