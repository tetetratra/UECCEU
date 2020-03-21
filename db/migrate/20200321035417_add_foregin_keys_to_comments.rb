class AddForeginKeysToComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :lecture_id
    add_reference :comments, :course, foreign_key: true
  end
end
