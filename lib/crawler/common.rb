require 'nokogiri'
require 'pry'
require 'active_record'
require 'open-uri'

require_relative './crawler.rb'
require_relative './parser.rb'

ActiveRecord::Base.establish_connection(
  adapter:  'mysql2',
  host:     'localhost',
  username: 'root',
  password: '',
  database: 'classshare_development',
)

class Course < ActiveRecord::Base
end


