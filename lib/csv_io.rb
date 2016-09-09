require "CSV"
module CsvIO

  def loader (path = "./test/fixtures/event_attendees.csv")
    CSV.open path, headers: true, header_converters: :symbol
  end

  def write_new_csv(old_csv)
    path = old_csv.path
    name = path.split("/").last
    new_csv = CSV.open("new_#{name}", "wb")
    old_csv.each do |row|
      new_csv << old_csv.headers if old_csv.lineno == 2
      new_csv << row
    end
    new_csv
  end

end
