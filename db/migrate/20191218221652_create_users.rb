class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string  :username
      t.string  :email
      t.string  :password_digest
      t.string  :refresh_token
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
