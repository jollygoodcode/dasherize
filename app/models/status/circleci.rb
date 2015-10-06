class Status::Circleci < Status::Base
  ENDPOINT = "https://circleci.com/api/v1/project".freeze

  def status
    case api_result
      when "fixed", "success"
        :passed
      when "retried", "canceled", "infrastructure_fail", "timedout", "failed", "no_tests"
        :failed
      else # "not_run", "running", "queued", "scheduled", "not_running"
        :waiting
    end
  end

  private

    def api_endpoint
      if auth_token
        "#{ENDPOINT}/#{repo_name}?circle-token=#{auth_token}"
      else
        "#{ENDPOINT}/#{repo_name}"
      end
    end

    def api_result
      response.find { |build| build["branch"] == branch }["status"]
    end

    def response
      JSON.parse(HTTP.headers(accept: "application/json").get(api_endpoint))
    end
end
