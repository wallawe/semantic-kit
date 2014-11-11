class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :title
      t.string :description
      t.text :html
      t.text :css
      t.text :js

      t.timestamps
    end
  end
end
