module CampusCrawler
  class Handler
    def self.start_crawling(current_year = Time.now.year)
      if Year.find_by(year: current_year).nil?
        year_rec = Year.create(year: current_year)
      else
        year_rec = Year.find_by(year: current_year)
      end
      self.update_courses(current_year, year_rec)
      self.add_inner_index(year_rec)
    end

    def self.update_courses(current_year, year_rec)
      facultys_page = Crawler.crawl_facultys(current_year)
      faculty_urls  = Parser.parse_facultys(facultys_page)
      faculty_urls.each do |faculty_url| # 昼や夜ごと
        puts "===== #{faculty_url[:curriculum]} ====="
        course_list_page = Crawler.crawl_course_list(current_year, faculty_url[:href])
        course_list      = Parser.parse_course_list(course_list_page)
        course_list.each do |course_info| # 授業ごと
          sleep 0.5
          puts course_info[:text]
          course_page = Crawler.crawl_course(current_year, course_info)
          course      = Parser.parse_course(course_page).merge(
            { curriculum: faculty_url[:curriculum], day_and_period: course_info[:day_and_period], timetable_code: course_info[:timetable_code] }
          )
          course_rec = year_rec.courses.find_by(timetable_code: course[:timetable_code])
          if course_rec.nil?
            year_rec.courses.create(course)
          else
            course_rec.update(course)
          end
        end
      end
    end

    def self.add_inner_index(year_rec)
      counter = Hash.new(1)
      year_rec.courses.each do |course|
        ind = counter[course.url_name]
        course.update(inner_index: ind)
        counter[course.url_name] += 1
      end
    end
  end
end
