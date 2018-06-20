module AAA
  class AddMicahs < ActiveRecord::Migration
    def change
      create_table :micahs do |t|
        t.string :name, null: false
        t.timestamps null: false
      end
    end
  end
end
