class AddYearIdToCourses < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :year, foreign_key: true
  end
end
