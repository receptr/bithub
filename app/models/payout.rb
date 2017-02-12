# A state-based object which is dependent upon a merge happening. When there's a
# new merge, we create one of these payouts which will go from pending to
# approved. When a payout is approved by at least a minimum number of people, it
# will be able to transition to an approved state. From there, money is released
# and sent to the developers.
class Payout < ApplicationRecord
  MINIMUM_APPROVAL_COUNT = 2

  has_many :approvals
  has_many :users, through: :approvals

  has_one :author, through: :merge

  belongs_to :merge

  validates :merge_id, :amount, :address, presence: true

  # Updates the state of the {Payout} from pending to approved.
  #
  # @param releaser [User] the user that released the payment.
  def release!(releaser)
    update!(released_by: releaser, released_at: DateTime.current)
    send_moola!
  end

  # Sends money of the amount stored in the payout to the author.
  def send_moola!
    # @todo
  end
end
