class AddUserSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :music_genre, :string, :default => 'classical'
    add_column :users, :dyslexic_font, :boolean, :default => false
    add_column :users, :dark_mode, :boolean, :default => false
    add_column :users, :font_size, :integer, :default => 20
  end
end
