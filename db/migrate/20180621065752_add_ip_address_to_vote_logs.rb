class AddIpAddressToVoteLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :like_logs, :ip_address, :string
  end
end
