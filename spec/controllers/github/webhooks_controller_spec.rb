describe Github::WebhooksController do
  describe '#create' do
    after { clear_enqueued_jobs }

    let(:webhook_payload) do
      {
        pull_request: {
          merged: true,
          merged_by: { login: 'merger' },
          user: { login: 'author' }
        }
      }
    end

    context 'when the request is for a pull request opening' do
      subject do
        post :create, params: {
          webhook: {
            pull_request: {}
          }
        }
      end

      it { should have_http_status 204 }
    end

    context 'when the request if for a pull request getting rejected' do
      subject do
        post :create, params: {
          webhook: {
            pull_request: {
              merged: false
            }
          }
        }
      end

      it { should have_http_status 204 }
    end

    context 'when the request is for a pull request closing on merge' do
      subject { post :create, params: { webhook: webhook_payload } }

      context 'when the request is for a pull request being merged' do
        it { should have_http_status 201 }

        it 'will create a new merge record' do
          expect { subject }.to change { Merge.count }.from(0).to(1)
        end

        it 'will create a new payout job' do
          expect { subject }.to change { enqueued_jobs.size }.from(0).to(1)
        end

        it 'will store the author and merger' do
          expect { subject }.to change { User.count }.from(0).to(2)
        end
      end

      context 'when the author already exists' do
        before { User.create!(github_username: 'author') }

        it 'will attach the merge to their account' do
          expect { subject }.to change { User.count }.from(1).to(2)
        end
      end

      context 'when the merger already exitst' do
        before { User.create!(github_username: 'merger') }

        it 'will attach the merge to their account' do
          expect { subject }.to change { User.count }.from(1).to(2)
        end
      end
    end
  end
end
