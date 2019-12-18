class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.integer :guten_id, null: false
      t.string  :author
      t.string  :title
      t.string  :img_url
      t.index   :guten_id, unique: true
      
      t.timestamps
    end
  end
end
