class RemoveConfirmPassFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :confirm_pass, :string
  end
end
