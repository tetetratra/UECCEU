class ChangeColumnTypeYear < ActiveRecord::Migration[6.0]
  def change
    change_column :lectures, :year, :integer
  end
end
