class Status::Circleci < Status::Base
  ENDPOINT = "https://circleci.com/api/v1/project".freeze

  def status
    case build_state
      when "fixed", "success"
        :passed
      when "retried", "canceled", "infrastructure_fail", "timedout", "failed", "no_tests"
        :failed
      else # "not_run", "running", "queued", "scheduled", "not_running"
        :waiting
    end
  end

  def url
    build_url
  end

  private

    def api_result
      JSON.parse(HTTP.headers(headers).get(api_endpoint)).first
    end

    def build_state
      api_result["status"]
    end

    def build_url
      api_result["build_url"]
    end

    def api_endpoint
      if auth_token
        "#{ENDPOINT}/#{repo_name}/tree/#{branch}?circle-token=#{auth_token}"
      else
        "#{ENDPOINT}/#{repo_name}/tree/#{branch}"
      end
    end

    def headers
      { accept: "application/json" }
    end
end
