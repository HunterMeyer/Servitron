class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.text :website
      t.text :file_url
      t.text :callback_url
      t.text :status
      t.json :options
      t.timestamps
    end

    add_index :screenshots, [:website], name: 'screenshots_website'
    add_index :screenshots, [:status],  name: 'screenshots_status'
  end
end
