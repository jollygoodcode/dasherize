class Status::Travis < Status::Base
  ENDPOINT = "https://api.travis-ci.org/repos".freeze

  def status
    case build_state
      when "passed"
        :passed
      when "failed"
        :failed
      else
        :waiting
    end
  end

  def url
    "https://travis-ci.org/#{repo_name}/builds/#{build_id}"
  end

  private

    def api_result
      JSON.parse(HTTP.headers(headers).get(api_endpoint))
    end

    def build_state
      api_result["branch"]["state"]
    end

    def build_id
      api_result["branch"]["id"]
    end

    def api_endpoint
      if auth_token.present?
        "#{ENDPOINT}/#{repo_name}/branches/#{branch}.json&token=#{auth_token}"
      else
        "#{ENDPOINT}/#{repo_name}/branches/#{branch}.json"
      end
    end

    def headers
      { "User-Agent" => "Dasherize/1.0.0", accept: "application/vnd.travis-ci.2+json" }
    end
end
