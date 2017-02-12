describe Payout do
  it { should have_many :approvals }
  it { should have_many(:users).through :approvals }

  it { should have_one(:author).through :merge }

  it { should belong_to :merge }
end
