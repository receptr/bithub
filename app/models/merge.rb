# This class refers to when a PR on Github has been merged and closed. We want
# to track when a merge has happened and record it here.
class Merge < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :pull_requests
  belongs_to :merger, class_name: 'User', inverse_of: :merges

  validates :author_id, :merger_id, :payload, presence: true

  delegate :toggl?, to: :author

  def amount
    @amount ||= begin
      case merge
      when toggl?
        # get amount from toggl
      when bounty?
        # get amount from bounty
      end
    end
  end
end
