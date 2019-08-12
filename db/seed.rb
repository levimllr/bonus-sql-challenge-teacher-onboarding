require 'csv'

# Parse the CSV and seed the database here! Run 'ruby db/seed' to execute this code.

fields_to_insert = %w{ YEAR GoogleKnowlege_Occupation Show Group Raw_Guest_List }
rows_to_insert = []

CSV.foreach("daily_show_guests.csv", headers: true) do |row|
  row_to_insert = row.to_hash.select { |k, v| fields_to_insert.include?(k) }
  rows_to_insert << row_to_insert
end

rows_to_insert.each do |row|
  @db.execute( "INSERT INTO daily_show_guests VALUES ( ?, ?, ?, ?, ?)", row['YEAR'], row['GoogleKnowlege_Occupation'], row['Show'], row['Group'], row['Raw_Guest_List'])
end
