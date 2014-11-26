class AddImageToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :image, :string
  end
end
