module Github
  class WebhooksController < Github::BaseController
    before_action :ensure_merge_action

    def create
      author = User.find_or_create_by!(github_username: author_username)
      merger = User.find_or_create_by!(github_username: merger_username)

      merge = Merge.create!(payload: params, author: author, merger: merger)
      PayoutJob.perform_later(merge)

      render status: 201
    end

    private

    def ensure_merge_action
      render status: 204 unless merged?
    end

    def author_username
      params[:webhook][:pull_request][:user][:login]
    end

    def merger_username
      params[:webhook][:pull_request][:merged_by][:login]
    end

    def merged?
      params[:webhook][:pull_request][:merged] == 'true'
    rescue NoMethodError
      false
    end
  end
end
