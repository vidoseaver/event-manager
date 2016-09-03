require "CSV"
class Queue

  def load (path = "./test/fixtures/event_attendees.csv")
    csv = CSV.open path, headers: true, header_converters: :symbol
  end



end
