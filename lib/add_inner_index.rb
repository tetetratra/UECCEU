
counter = Hash.new(1)
Course.all.each do |course|
  ind = counter[course.url_name]
  course.update(inner_index: ind)
  counter[course.url_name] += 1
end

