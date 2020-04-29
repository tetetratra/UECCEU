module CampusCrawler
  class Crawler
    def self.crawl_facultys(year)
      html = URI.open("http://kyoumu.office.uec.ac.jp/syllabus/#{year}/top_shozoku.html").read
      html
    end

    def self.crawl_course_list(year, faculty_path)
      url = "http://kyoumu.office.uec.ac.jp/syllabus/#{year}/#{faculty_path}"
      html = URI.open(url).read
      html
    end

    def self.crawl_course(year, course_url)
      url = "http://kyoumu.office.uec.ac.jp/syllabus/#{year}/#{course_url[:href]}"
      html = URI.open(url).read
      html
    end
  end
end
