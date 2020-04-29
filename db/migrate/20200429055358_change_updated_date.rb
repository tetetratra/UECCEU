class ChangeUpdatedDate < ActiveRecord::Migration[6.0]
  def change
    change_column :courses, :updated_date, :datetime
  end
end
