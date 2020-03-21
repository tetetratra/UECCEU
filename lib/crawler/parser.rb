class Parser
  def self.parse_facultys(facultys_page)
    doc = Nokogiri::HTML.parse(facultys_page)
    faculty_urls = doc.css('table[align="center"][width="500"] tr a').map do |faculty_node|
      {
        href: faculty_node[:href],
        text: faculty_node.text
      }
    end
    faculty_urls
  end

  def self.parse_course_list(course_list_page)
    doc = Nokogiri::HTML.parse(course_list_page)
    course_list = doc.css('table tr[onmouseout="TRMouseOut(this)"]').map do |course_node|
      {
        href: course_node.at_css('> td > a')[:href],
        text: course_node.at_css('> td > a').text
      }
    end
    course_list
  end

  def self.parse_course(course_page, year)
    doc = Nokogiri::HTML.parse(course_page)
    course = doc.css('table.syllabus-normal th + td').map { |cell_node|
      cell_node.text.strip
    }.zip(
      [
        :course_title_japanese,
        :course_title_english,
        :code,
        :academic_year,
        :year_offerd,
        :semester_offerd,
        :faculty_offering_the_course,
        :teaching_method,
        :credits,
        :category,
        :cluster_and_department,
        :lecturer,
        :office,
        :email,
        :course_website,
        :last_updated,
        :update_status,
        :topic_and_goals,
        :prerequisites,
        :recommended_prerequisites_and_preparation,
        :course_textbooks_and_materials,
        :course_outline_and_weekly_schedule,
        :course_content_utilizing_practical_experience,
        :preparation_and_review_outside_class,
        :evaluation_and_grading,
        :office_hours,
        :message_for_students,
        :other,
        :keyword,
      ]
    ).map { |(text, category)|
      { category => text }
    }.inject(:merge)

    course_with_meta = course.merge(
      {
        year: year,
        url_name: course[:course_title_english].gsub(/\s/, '_').downcase.then{ |init_str|
          ['ⅰ','ⅱ','ⅲ','ⅳ','ⅴ','ⅵ','ⅶ','ⅷ','ⅸ','ⅹ']
          .each.with_index(1)
          .inject(init_str) { |str, (char, ind)|
            str.gsub(char, ind.to_s)
          }
        } # 空白はアンダーバーでつないで、ローマ数字は数字に変換する
      }
    )
    course_with_meta
  end
end


{
  course_title_japanese: '',
  course_title_english: '',
  code: '',
  academic_year: '',
  year_offerd: '',
  semester_offerd: '',
  faculty_offering_the_course: '',
  teaching_method: '',
  credits: '',
  category: '',
  cluster_and_department: '',
  lecturer: '',
  office: '',
  email: '',
  course_website: '',
  last_updated: '',
  update_status: '',
  topic_and_goals: '',
  prerequisites: '',
  recommended_prerequisites_and_preparation: '',
  course_textbooks_and_materials: '',
  course_outline_and_weekly_schedule: '',
  course_content_utilizing_practical_experience: '',
  preparation_and_review_outside_class: '',
  evaluation_and_grading: '',
  office_hours: '',
  message_for_students: '',
  other: '',
  keyword: ''
}
