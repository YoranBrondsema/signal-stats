# frozen_string_literal: true

require 'json'

# Link to the backup CSV.
filepath = ARGV[0]
# Number of the person you want to analyze your conversations of.
number = ARGV[1]

messages = []
File.foreach(filepath) do |line|
  begin
    json = JSON.parse(line)

    if json["delivered_to"] == [number] || json["source"] == number
      messages << {
        date_sent: Time.at(json['sent_at'].to_i / 1000)
      }
    end
  rescue
  end
end

messages
  .group_by { |message| message[:date_sent].year }
  .each { |year, msgs| puts "#{year}: #{msgs.count} messages" }

puts "Total number of messages: #{messages.count}"
puts "Earliest date: #{messages[0][:date_sent].strftime('%B %e, %Y')}"
