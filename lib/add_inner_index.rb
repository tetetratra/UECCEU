require 'pry'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'mysql2',
  host:     'localhost',
  username: 'root',
  password: '',
  database: 'classshare_development',
)

class Course < ActiveRecord::Base
end


counter = Hash.new(1)

Course.all.each do |course|
  new_url = course.url_name.gsub(/[ー－]/, '-').gsub('　', '_').gsub(/[:;,.]/, '').tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z')
  course.update(url_name: new_url)
end

Course.all.each do |course|
  ind = counter[course.url_name]
  course.update(inner_index: ind)
  counter[course.url_name] += 1
end

