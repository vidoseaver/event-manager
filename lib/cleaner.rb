module Cleaner
  def standardize_zipcode(zipcode = nil)
    zipcode.to_s.rjust(5,"0")[0..4]
  end

  def standardize_phone_number(phone_number = nil)
    return "0"              if phone_number.nil?
    number = number_cleaner(phone_number.to_s)
    return number           if number.length == 10 && !number.start_with?("0")
    return number[1..10]    if number.length == 11 && number.start_with?("1")
    return "0"
  end

  def number_cleaner(number)
    number.gsub(/[^0-9]/, "")
  end

  def standardize_text(input)
    return "0" if input.nil?
    input.to_s.downcase
  end
end
