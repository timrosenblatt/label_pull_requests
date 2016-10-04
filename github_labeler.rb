class GitHubLabeler
  def initialize(github, labeler)
    @github = github
    @labeler = labeler
  end

  def add_labels_to_pull_request(webhook)
    project = webhook["repository"]["full_name"]
    number = webhook["pull_request"]["number"]
    base = webhook["pull_request"]["base"]["sha"]
    head = webhook["pull_request"]["head"]["sha"]

    changes = @github.compare(project, base, head)
    files = changes["files"].map { |file| file["filename"] }

    labels = @labeler.for(*files)
    @github.add_labels_to_an_issue(project, number, labels)
  end
end
