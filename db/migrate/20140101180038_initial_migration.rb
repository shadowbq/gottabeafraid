class InitialMigration < ActiveRecord::Migration
  def up
    create_table :afraids do |t|
      t.string :domain_name
      t.integer :hosts
      t.string :security
      t.string :user
      t.datetime :age
    end

 
    add_index :afraids, :domain_name
  end

  def down
    drop_table :afraids
  end
end
