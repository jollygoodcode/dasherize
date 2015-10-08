class Status::Codeship < Status::Base
  def status
    case build_state
      when :success
        :passed
      when :error, :projectnotfound, :branchnotfound, :ignored, :stopped, :infrastructure_failure
        :failed
      else # :testing, :waiting
        :waiting
    end
  end

  def url
    "https://codeship.com/projects"
  end

  private

    def api_result
      Codeship::Status.new(auth_token, branch: branch)
    end

    def build_state
      api_result.status
    end
end
