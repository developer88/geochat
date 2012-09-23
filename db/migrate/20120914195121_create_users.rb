class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :login
      t.string :identity
      t.string :provider
      t.string :uid
      t.string :name
      t.string :lat
      t.string :lng

      t.timestamps
    end
    add_index :users, [:lat, :lng]
    add_index :users, :login
    add_index :users, [:identity, :provider]
  end
end
