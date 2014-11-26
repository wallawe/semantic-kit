class RemoveDescriptionFromSnippets < ActiveRecord::Migration
  def change
    remove_column :snippets, :description, :text
  end
end
