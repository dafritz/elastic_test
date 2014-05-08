class CreateSearchData < ActiveRecord::Migration
  def change
    create_table :search_data do |t|
      t.text :record_body
      t.string :record_name
      t.timestamps
    end
  end
end
