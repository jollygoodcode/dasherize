module APIHelper
  def stub_ci_requests_for_home_page
    stub_request(
      :get, "https://api.github.com/repos/sinatra/sinatra/issues?per_page=100"
    ).with(
      headers: { "Content-Type" => "application/json" }
    ).to_return(
      status: 200, body: IO.read("spec/fixtures/github/sinatra.json"),
      headers: { "Content-Type" => "application/json" }
    )

    stub_request(
      :get, "https://api.github.com/repos/jollygoodcode/twemoji/issues?per_page=100"
    ).with(
      headers: { "User-Agent" => "Octokit Ruby Gem 4.1.1" }
    ).to_return(
      status: 200, body: IO.read("spec/fixtures/github/twemoji.json"),
      headers: { "Content-Type" => "application/json" }
    )

    stub_request(
      :get, "https://api.github.com/repos/winston/google_visualr/issues?per_page=100"
    ).with(
      headers: { "User-Agent" => "Octokit Ruby Gem 4.1.1" }
    ).to_return(
      status: 200, body: IO.read("spec/fixtures/github/google_visualr.json"),
      headers: { "Content-Type" => "application/json" }
    )

    stub_request(
      :get, "https://api.travis-ci.org/repos/sinatra/sinatra.json?branch=master"
    ).with(
      headers: { "User-Agent" => "Dasherize/1.0.0", "Accept" => "application/vnd.travis-ci.2+json" }
    ).to_return(
      status: 200, body: IO.read("spec/fixtures/travis/sinatra.json"),
      headers: { "Content-Type" => "application/json" }
    )

    stub_request(
      :get, "https://api.travis-ci.org/repos/jollygoodcode/twemoji.json?branch=master"
    ).with(
      headers: { "User-Agent" => "Dasherize/1.0.0", "Accept"=>"application/vnd.travis-ci.2+json" }
    ).to_return(
      status: 200, body: IO.read("spec/fixtures/travis/twemoji.json"),
      headers: { "Content-Type" => "application/json" }
    )

    stub_request(
      :get, "https://api.travis-ci.org/repos/winston/google_visualr.json?branch=master"
    ).with(
      headers: { "User-Agent" => "Dasherize/1.0.0", "Accept" => "application/vnd.travis-ci.2+json" }
    ).to_return(
      status: 200, body: IO.read("spec/fixtures/travis/google_visualr.json"),
      headers: { "Content-Type" => "application/json" }
    )
  end
end
