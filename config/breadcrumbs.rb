
crumb :root do
  link "トップページ", root_path
end

crumb :year do
  link params[:year], year_path
end

crumb :course do
  link params[:url_name], year_courses_path
  parent :year
end

