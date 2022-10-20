class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.string :address
      t.date :birthday
      t.string :profile
      t.boolean :admin_flg
      t.datetime :deleted_at
      t.numeric :created_user
      t.numeric :updated_user
      t.numeric :deleted_user

      t.timestamps
    end
  end
end
