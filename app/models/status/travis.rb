class Status::Travis < Status::Base
  def status
    case api_result
      when 0
        :passed
      when 1
        :failed
      else
        :waiting
    end
  end

  private

    def api_endpoint
      url  = "https://api.travis-ci.org/repos/#{repo_name}.json?branch=#{branch}"
      url += "&token=#{auth_token}" if auth_token.present?
      url
    end

    def api_result
      JSON.parse(HTTP.headers(headers).get(api_endpoint))["last_build_status"]
    end

    def headers
      { "User-Agent" => "Dasherize/1.0.0", accept: "application/vnd.travis-ci.2+json" }
    end
end
