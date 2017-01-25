class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :first_name
      t.text :last_name
      t.text :email
      t.text :api_key
      t.text :status,         default: 'Active'
      t.boolean :api_enabled, default: false
    end

    add_index :users, :status
    add_index :users, :api_key
  end
end
