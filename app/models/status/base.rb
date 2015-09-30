module Status
  class Base
    attr_reader :repo_name, :auth_token

    def initialize(repo_name, auth_token=nil)
      @repo_name  = repo_name
      @auth_token = auth_token
    end

    def branch
      "master"
    end
  end
end
