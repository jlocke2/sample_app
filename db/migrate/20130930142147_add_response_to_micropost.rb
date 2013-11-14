class AddResponseToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :response, :string
  end
end
