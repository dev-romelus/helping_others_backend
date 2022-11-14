class ChangeStatusToBeStringInServices < ActiveRecord::Migration[7.0]
  def change
    change_column :services, :status, :string
    change_column_default :services, :status, from: true, to: 'IN_PROGRESS'
  end
end
