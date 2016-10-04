class Labeler
  def initialize(labels)
    @labels = labels
  end

  def labels(files)
    @labels.each_with_object([]) do |(label, patterns), matches|
      matches << label if match?(patterns, files)
    end
  end

  private

  def match?(patterns, files)
    patterns.any? do |pattern|
      files.any? do |file|
        File.fnmatch(pattern, file)
      end
    end
  end
end
