class AddColumnToUser < ActiveRecord::Migration[5.2]
 
  def change
  	 add_column :users, :name, :string
  	 add_column :users, :mobile, :string ,null: false,default: "",  unique: true
  	 add_column :users, :gender, :string
  	 add_column :users, :dob, :date
  	 add_column :users, :username, :string, null: false, default: "",  unique: true
  end
end
