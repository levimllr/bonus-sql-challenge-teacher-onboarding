require 'bundler'
require 'sqlite3'
Bundler.require

# Setup a DB connection here
@db = SQLite3::Database.new ":memory:"
@db.execute <<-SQL
  CREATE TABLE daily_show_guests (
    'year' int,
    'profession' string,
    'show' string,
    'group_type' string,
    'guests' string
  );
SQL
