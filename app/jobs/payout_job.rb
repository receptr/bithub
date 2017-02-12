# If the user has a bitcoin address, we're going to ask for approval from some
# services, otherwise we're going to email them and ask them for their Bitcoin
# address and re-perform this job later on.
class PayoutJob < ApplicationJob
  queue_as :default

  # @param Merge [merge]
  def perform(merge)
    return if merge.amount.zero?
    return unless bitcoin_address_present? merge

    Payout.create! do |payout|
      payout.merge = merge
      payout.amount = merge.amount
      payout.address = merge.author.bitcoin_address
    end

    NotificationMailer.new_payout(payout).deliver_now
  end

  private

  def bitcoin_address_present?(merge)
    return true if merge.author.bitcoin_address.present?

    BitcoinAddressMailer.request(merge).deliver_now
    false
  end
end
