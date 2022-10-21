class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.boolean :public_flg
      t.numeric :created_user
      t.numeric :updated_user

      t.timestamps
    end
  end
end
