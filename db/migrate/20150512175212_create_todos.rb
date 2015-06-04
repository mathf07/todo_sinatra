class CreateTodos < ActiveRecord::Migration
  def change
  	create_table :todos do |t|
  		t.text :content
  		t.boolean :done
  		t.datetime :completed_at
  		t.timestamps
  	end
  end
end
