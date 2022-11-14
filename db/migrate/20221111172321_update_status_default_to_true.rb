class UpdateStatusDefaultToTrue < ActiveRecord::Migration[7.0]
  def change
    change_column_default :services, :status, from: nil, to: true
  end
end
