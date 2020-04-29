class CreateCrawlHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :crawl_histories do |t|

      t.timestamps
    end
  end
end
