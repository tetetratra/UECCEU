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

  course_list.each do |course_info|
    sleep 0.5
    puts course_info[:text]
    course_page = Crawler.crawl_course(year, course_info)
    course      = Parser.parse_course(course_page, year, course_info)
    Course.create(course)
  end
end


counter = Hash.new(1)
Course.all.each do |course|
  ind = counter[course.url_name]
  course.update(inner_index: ind)
  counter[course.url_name] += 1
end

