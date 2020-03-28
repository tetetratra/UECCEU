class AddCommentCountToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :comment_count, :integer, default: 0
  end
end
