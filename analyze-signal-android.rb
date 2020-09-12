# frozen_string_literal: true

require 'csv'

# Link to the backup CSV.
filepath = ARGV[0]
# Thread ID the conversation you want to get stats from.
thread_id = ARGV[1]

messages = []
CSV.foreach(filepath, headers: true) do |row|
  if row['THREAD_ID'] == thread_id
    messages << {
      date_sent: Time.at(row['DATE_SENT'].to_i / 1000)
    }
  end
end

messages
  .group_by { |message| message[:date_sent].year }
  .each { |year, msgs| puts "#{year}: #{msgs.count} messages" }

puts "Total number of messages: #{messages.count}"
puts "Earliest date: #{messages[0][:date_sent].strftime('%B%e, %Y')}"
