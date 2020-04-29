class AddColumnToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :curriculum, :string
    add_column :courses, :updated_date, :string
  end
end
