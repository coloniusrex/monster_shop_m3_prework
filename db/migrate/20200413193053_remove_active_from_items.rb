class RemoveActiveFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :active?, :boolean
  end
end
