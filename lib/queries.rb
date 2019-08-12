require_relative '../config/environment'
require_relative '../db/seed'

# Write methods that return SQL queries for each part of the challeng here

# binding.pry

def guest_with_most_appearances
  puts "Q: Who did Jon Stewart have on the Daily Show the most?"
  most_guest = @db.execute( "SELECT COUNT(guests), guests FROM daily_show_guests GROUP BY guests ORDER BY COUNT(guests) DESC LIMIT 1" )[0]
  puts "A: #{most_guest[1]}, with #{most_guest[0]} appearances."
  puts ""
end

def profession_with_most_appearances_by_year
  puts "Q: What was the most popular profession of guest for each year Jon Stewart hosted the Daily Show?"
  years = @db.execute( "SELECT year FROM daily_show_guests GROUP BY year ORDER BY year DESC" ).flatten
  year_count_profession_array = []
  years.each do |year|
    year_count_profession_array << @db.execute( "
    SELECT year, COUNT(profession), profession 
    FROM daily_show_guests 
    WHERE year = #{year}
    GROUP BY profession 
    ORDER BY year DESC, COUNT(profession) DESC 
    LIMIT 1" ).flatten
  end
  year_count_profession_array.each do |year|
    puts "A: In #{year[0]}, the most popular profession was #{year[2]} with #{year[1]} appearances."
  end
  puts ""
end

def profession_with_most_appearances
  puts "Q: What profession did Jon Stewart have on the Daily Show the most?"
  most_profession = @db.execute( "SELECT COUNT(profession), profession FROM daily_show_guests GROUP BY profession ORDER BY COUNT(profession) DESC LIMIT 1" )[0]
  puts "A: #{most_profession[1].capitalize}, with #{most_profession[0]} appearances."
  puts ""
end

def how_many_bills
  puts "Q: How many people did Jon Stewart have on with the first name of Bill?"
  bills = @db.execute( "
    SELECT guests
    FROM daily_show_guests
    WHERE guests LIKE '%Bill%'
    ").flatten
  puts "A: #{bills.length} people appeared on the Daily Show with 'Bill' in their name."
  puts "" 
end

def when_patrick_stewart
  puts "Q: What dates did Patrick Stewart appear on the show?"
  patrick_dates = @db.execute( "
    SELECT show
    FROM daily_show_guests
    WHERE guests LIKE '%Patrick Stewart%'
    ").flatten
  patrick_dates_string = patrick_dates[0...-1].join(", ") + ", and " + patrick_dates[-1]
  puts "A: Patrick Stewart appeared on the Daily Show on the following dates: #{patrick_dates_string}"
  puts ""
end

def most_guests_year
  puts "Q: Which year had the most guests?"
  biggest_year = @db.execute( "
    SELECT year, COUNT(year)
    FROM daily_show_guests
    GROUP BY year
    ORDER BY COUNT(year) DESC
    LIMIT 1").flatten
  puts "A: #{biggest_year[0]} was the year with most guests, with #{biggest_year[1]} appearances in total."
  puts ""
end

def most_popular_group_by_year
  puts "Q: What was the most popular group for each year Jon Stewart hosted?"
  years = @db.execute( "SELECT year FROM daily_show_guests GROUP BY year ORDER BY year DESC" ).flatten
  year_count_group_array = []
  # binding.pry
  years.each do |year|
    year_count_group_array << @db.execute( "
    SELECT year, COUNT(group_type), group_type
    FROM daily_show_guests 
    WHERE year = #{year}
    GROUP BY group_type
    ORDER BY year DESC, COUNT(group_type) DESC 
    LIMIT 1" ).flatten
  end
  
  year_count_group_array.each do |year|
    puts "A: In #{year[0]}, the most popular group was #{year[2]} with #{year[1]} appearances."
  end
  puts ""
end

guest_with_most_appearances
profession_with_most_appearances_by_year
profession_with_most_appearances
how_many_bills
when_patrick_stewart
most_guests_year
most_popular_group_by_year