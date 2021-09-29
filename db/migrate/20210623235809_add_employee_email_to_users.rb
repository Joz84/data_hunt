class AddEmployeeEmailToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :employee_email, :string
  end
end
