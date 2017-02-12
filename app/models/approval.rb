# Records when an admin user has approved a payout.
class Approval < ApplicationRecord
  belongs_to :payout
  belongs_to :user

  validates :payout_id, :user_id, presence: true
end
