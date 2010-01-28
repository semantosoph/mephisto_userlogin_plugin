class InitialDatabaseMigration < ActiveRecord::Migration
  def self.up
    create_table :userlogins do |t|
      t.column :sites, :string
      t.column :login, :string, :limit => 40
      t.column :encrypt, :boolean, :default => true
      t.column :password, :string, :limit => 40
      t.column :salt, :string, :limit => 40
      t.column :remember_token, :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
    end
  end
 
  def self.down
    drop_table :userlogins
  end
end
