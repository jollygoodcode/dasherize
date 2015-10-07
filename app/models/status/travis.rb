class Status::Travis < Status::Base
  def status
    case api_result
      when "passed"
        :passed
      when "failed"
        :failed
      else
        :waiting
    end
  end

  private

    def api_result
      JSON.parse(HTTP.headers(headers).get(api_endpoint))["branch"]["state"]
    end

    def api_endpoint
      if auth_token.present?
        "https://api.travis-ci.org/repos/#{repo_name}/branches/#{branch}.json&token=#{auth_token}"
      else
        "https://api.travis-ci.org/repos/#{repo_name}/branches/#{branch}.json"
      end
    end

    def headers
      { "User-Agent" => "Dasherize/1.0.0", accept: "application/vnd.travis-ci.2+json" }
    end
end
