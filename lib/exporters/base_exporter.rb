class BaseExporter
  def initialize(results)
    @results = results
  end

  def export(filename)
    raise NotImplementedError, "Subclasses must implement export method"
  end

  protected

  def ensure_directory(filename)
    dir = File.dirname(filename)
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
  end
end 