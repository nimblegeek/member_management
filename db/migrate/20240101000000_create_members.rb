class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone
      t.date :date_of_birth
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :rank, null: false, default: "White Belt"
      t.date :join_date
      t.boolean :active, null: false, default: true
      t.text :notes
      
      t.timestamps
    end
    
    add_index :members, :email, unique: true
    add_index :members, [:last_name, :first_name]
    add_index :members, :active
  end
end 