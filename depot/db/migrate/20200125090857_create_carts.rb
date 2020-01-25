class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.timestamps
    end
  end
end

class DropTableCarts < ActiveRecord::Migration[5.1]
  def change
    drop_table :carts  
  end
end