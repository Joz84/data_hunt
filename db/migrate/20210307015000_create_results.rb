class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.string :website
      t.string :employee_email
      t.string :employee_pwd
      t.string :db_password
      t.string :url
      t.string :port
      t.string :user
      t.string :name
      t.string :place
      t.string :color

      t.timestamps
    end
  end
end
