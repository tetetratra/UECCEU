module CampusCrawler
  class Parser
    def self.parse_facultys(facultys_page)
      doc = Nokogiri::HTML.parse(facultys_page)
      faculty_urls = doc.css('table[align="center"][width="500"] tr a').map do |faculty_node|
        {
          href: faculty_node[:href],
          curriculum: faculty_node.text
        }
      end
      faculty_urls
    end

    def self.parse_course_list(course_list_page)
      doc = Nokogiri::HTML.parse(course_list_page)
      course_list = doc.css('table tr[onmouseout="TRMouseOut(this)"]').map do |course_node|
        {
          href: course_node.at_css('> td > a')[:href],
          text: course_node.at_css('> td > a').text,
          day_and_period: course_node.at_css('> td:nth-child(4)').text,
          timetable_code: course_node.at_css('> td:nth-child(5)').text
        }
      end
      course_list
    end

    CATEGORY_MASTER= {
      '授業科目名' => :course_title_japanese,
      '英文授業科目名' => :course_title_english,
      '科目番号' => :code,
      '開講年度' => :academic_year,
      '開講年次' => :year_offerd,
      '開講学期' => :semester_offerd,
      '開講コース・課程' => :faculty_offering_the_course,
      '授業の方法' => :teaching_method,
      '単位数' => :credits,
      '科目区分' => :category,
      '開講学科・専攻' => :cluster_and_department,
      '担当教員名' => :lecturer,
      '居室' => :office,
      '公開E-Mail' => :email,
      '授業関連Webページ' => :course_website,
      '更新日' => :last_updated,
      '更新状況' => :update_status,
      '主題および達成目標' => :topic_and_goals,
      '前もって履修しておくべき科目' => :prerequisites,
      '前もって履修しておくことが望ましい科目' => :recommended_prerequisites_and_preparation,
      '教科書等' => :course_textbooks_and_materials,
      '授業内容とその進め方' => :course_outline_and_weekly_schedule,
      '実務経験を活かした授業内容(実務経験内容も含む)' => :course_content_utilizing_practical_experience,
      '授業時間外の学習（予習・復習等）' => :preparation_and_review_outside_class,
      '成績評価方法および評価基準（最低達成基準を含む）' => :evaluation_and_grading,
      'オフィスアワー：授業相談' => :office_hours,
      '学生へのメッセージ' => :message_for_students,
      'その他' => :other,
      'キーワード' => :keyword,
      # ここから大学院のシラバス用
      '講義の狙い、目標' => :topic_and_goals,
      '内容' => :course_outline_and_weekly_schedule,
      '教科書、参考書' => :course_textbooks_and_materials,
      '予備知識' => :prerequisites,
      '演習' => :preparation_and_review_outside_class,
      '成績評価方法および評価基準' => :evaluation_and_grading,
    }

    def self.parse_course(course_page)
      doc = Nokogiri::HTML.parse(course_page)
      course = doc.css('table.syllabus-normal th + td').map do |cell_node|
        text = cell_node.children.slice_when{|n| n.name == 'br' }
                        .map{|para| para.map{|nn|nn.text.strip}.join + "\n" }
                        .join.strip
        category = CATEGORY_MASTER[cell_node.previous.previous.text.split('/')[0].strip]
        { category => text }
      end.inject(:merge)
      course_full = course.merge(
        {
          updated_date: doc.at_css('body > div[style] > b').text[%r{\d+/\d+/\d+}].then { |te| Time.strptime(te, '%Y/%m/%d') },
          url_name: course[:course_title_english].gsub(/\s/, '_').downcase.then{ |init_str|
            ['ⅰ','ⅱ','ⅲ','ⅳ','ⅴ','ⅵ','ⅶ','ⅷ','ⅸ','ⅹ']
            .each.with_index(1)
            .inject(init_str) { |str, (char, ind)|
              str.gsub(char, ind.to_s)
            }.gsub(/[ー－]/, '-').gsub('　', '_').gsub(/[:;,.]/, '').tr('０-９ａ-ｚＡ-Ｚ', '0-9a-zA-Z').downcase
          } # 空白はアンダーバーでつないで、ローマ数字は数字に変換する
        }
      )
      course_full
    end
  end
end
