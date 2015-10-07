class ProjectDecorator < SimpleDelegator
  def process_with(oauth_token=nil)
    @oauth_token = oauth_token

    call_apis
  end

  def org_user
    @_org_user ||= repo_name.split("/").first
  end

  def name
    @_name ||= repo_name.split("/").last
  end

  def url
    "https://github.com/#{repo_name}"
  end

  def pull_requests_url
    "https://github.com/#{repo_name}/pulls"
  end

  def issues_url
    "https://github.com/#{repo_name}/issues"
  end

  def pull_requests
    @_prs ||= @_issues.select(&:pull_request)
  end

  def issues
    @_iss ||= @_issues.reject(&:pull_request)
  end

  def status
    @_status
  end

  private

    def call_apis
      Parallel.each(api_functions, in_threads: api_functions.size) { |func| func.call }
    end

    def api_functions
      [
        method(:init_repos),
        method(:init_ci)
      ]
    end

    def init_repos
      client   = Octokit::Client.new(access_token: @oauth_token)
      @_issues = client.issues(repo_name)
    end

    def init_ci
      @_status =
        case ci_type
          when "travis"
            Status::Travis.new(repo_name, travis_token).status
          when "codeship"
            Status::Codeship.new(repo_name, codeship_uuid).status
          when "circleci"
            Status::Circleci.new(repo_name, circleci_token).status
          else
            :unavailable
        end
    end
end
