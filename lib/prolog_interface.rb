require 'open3'
require 'tmpdir'

class PrologInterface
  def initialize(debug: false)
    @debug = debug
    @prolog_path = find_prolog_executable
    raise "SWI-Prolog not found" unless @prolog_path
    
    init_prolog
  end

  def query(goal)
    cmd = [@prolog_path, '-q', '-g', goal, '-t', 'halt']
    stdout, stderr, status = Open3.capture3(*cmd)
    
    if @debug
      puts "Prolog Query: #{goal}"
      puts "Output: #{stdout}"
      puts "Errors: #{stderr}" unless stderr.empty?
    end
    
    if status.success?
      parse_response(stdout)
    else
      handle_error(stderr)
      []
    end
  end

  private

  def init_prolog
    init_file = create_init_file
    cmd = [@prolog_path, '-s', init_file, '-g', 'true', '-t', 'halt']
    stdout, stderr, status = Open3.capture3(*cmd)
    
    if @debug
      puts "Prolog initialization:"
      puts "Output: #{stdout}"
      puts "Errors: #{stderr}" unless stderr.empty?
    end

    File.unlink(init_file) if File.exist?(init_file)
    
    unless status.success?
      raise "Prolog initialization failed: #{stderr}"
    end
  end

  def create_init_file
    temp_file = File.join(Dir.tmpdir, "prolog_init_#{Process.pid}.pl")
    File.write(temp_file, <<~PROLOG)
      :- set_prolog_flag(float_format, '%.10g').
      :- initialization(main).
      
      main :- 
          consult('#{File.join(__dir__, 'patterns', 'basic_patterns.pl')}'),
          true.
    PROLOG
    temp_file
  end

  def parse_response(output)
    return [] if output.strip.empty?
    output.lines.map do |line|
      line.strip.gsub(/[\[\]]/, '').split(',').map(&:strip)
    end
  end

  def handle_error(error)
    puts "Prolog Error: #{error}"
  end

  def find_prolog_executable
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |dir|
      prolog = File.join(dir, 'swipl')
      return prolog if File.executable?(prolog)
    end
    nil
  end
end 