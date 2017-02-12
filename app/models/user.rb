# A user is a reference to their Github profile. We cache and reference a user's
# bitcoin address in here as well.
class User < ApplicationRecord
  has_many :pull_requests, class_name: 'Merge', foreign_key: :author_id
  has_many :merges, foreign_key: :merger_id

  validates :github_username, presence: true

  # Checks the timestamp of the adminified_at and determines if the user is an
  # admin.
  #
  # @return [Boolean]
  def admin?
    !adminified_at.nil?
  end
end
