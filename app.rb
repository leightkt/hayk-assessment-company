require 'pry'
require 'sqlite3'
require_relative './lib/Company.rb'

DB = {:conn => SQLite3::Database.new("db/companies.db")}

Company.create_table
Company.new("You better not save", 0)
Company.create("Bob's Burgers", 5)
Company.create("Satan's Asshole AKA Amazon", 1000000)
Company.create("Awakening", 15)
Company.create("Queen City", 20)
Company.create("Self Employed Enterprise", 1)

# Company.find_by_name("Bob's Burgers")

# Company.all

# awakening = Company.find_by_name("Awakening")
# awakening.num_of_emp = 222
# awakening.update

# Company.find_by_name("Awakening")

# Company.find_by_name("Bob's Burgers").delete



binding.pry