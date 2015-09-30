class Status::Codeship < Status::Base
  def status
    case api_result
      when :success
        :passed
      when :error, :projectnotfound, :branchnotfound, :ignored, :stopped, :infrastructure_failure
        :failed
      else # :testing, :waiting
        :waiting
    end
  end

  private

    def api_result
      Codeship::Status.new(auth_token, branch: branch).status
    end
end
