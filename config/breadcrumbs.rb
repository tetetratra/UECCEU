crumb :root do
  link 'TOP', root_path
end

crumb :year_index do
  link '年度一覧', years_path
  parent :root
end

crumb :year do
  # 見る場所によってparamに入る値が違うのでこうなってしまっている
  link (params[:year_id] || params[:id]).to_s, year_path(id: (params[:year_id] || params[:id]))
  parent :year_index
end

crumb :course_index do
  link '授業一覧', year_courses_path
  parent :year
end

crumb :course do
  link params[:id], year_course_path
  parent :course_index
end
