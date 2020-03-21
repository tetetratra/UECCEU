class AddColumnEnglishName < ActiveRecord::Migration[6.0]
  def change
    add_column :lectures, :english_name, :string

    add_column :lectures, :grade, :string # 受講できる学年
  end
end
