
crumb :root do
  link 'TOP', root_path
end

crumb :year do
  link params[:year], year_path
end

crumb :course_list do
  link params[:url_name], year_course_list_path
  parent :year
end

crumb :course do
  link params[:num], year_courses_path
  parent :course_list
end
