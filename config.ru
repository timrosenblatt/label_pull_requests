require "bundler/require"
require "json"

require_relative "github_labeler"

github = Octokit::Client.new(
  access_token: ENV.fetch("GITHUB_ACCESS_TOKEN")
)

github_labeler = GitHubLabeler.new(github, Owners)

post "/github/labeler" do
  webhook = JSON.parse(request.body.tap(&:rewind).read)
  github_labeler.add_labels_to_pull_request(webhook)
end

run Sinatra::Application
