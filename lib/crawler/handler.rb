require_relative './common.rb'

# (2010..2019)
year = 2019

facultys_page = Crawler.crawl_facultys(year)
faculty_urls  = Parser.parse_facultys(facultys_page)

# TODO どうにかする
# facultyによっては、courseページのカテゴリ数が少ないものがあるので、とりあえず情報理工学域のみとる。
faculty_urls = [faculty_urls[0]]


faculty_urls.each do |faculty_url|
  course_list_page = Crawler.crawl_course_list(year, faculty_url)
  course_list      = Parser.parse_course_list(course_list_page )

  course_list.each do |course|
    course_page = Crawler.crawl_course(year, course)
    course      = Parser.parse_course(course_page, year)
    Course.create(course)
  end
end


