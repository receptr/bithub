describe User do
  it { should have_many :pull_requests }
  it { should have_many :merges }

  describe '#admin' do
    context 'when there is no adminified_at' do
      its(:admin?) { should eql false }
    end

    context 'when there is an adminified_at' do
      subject { build :admin }

      its(:admin?) { should eql true }
    end
  end
end
