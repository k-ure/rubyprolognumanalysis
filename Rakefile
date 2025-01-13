require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

desc "Run the interactive console"
task :console do
  require 'irb'
  require_relative 'lib/analyzer'
  ARGV.clear
  IRB.start
end

desc "Install dependencies"
task :setup do
  puts "Checking Ruby dependencies..."
  system "bundle install"
  
  puts "\nChecking for SWI-Prolog..."
  if system("which swipl > /dev/null 2>&1")
    puts "SWI-Prolog found!"
  else
    puts "WARNING: SWI-Prolog not found! Please install it:"
    puts "  Ubuntu/Debian: sudo apt-get install swi-prolog"
    puts "  macOS: brew install swi-prolog"
    puts "  Windows: Download from https://www.swi-prolog.org/download/stable"
  end
end

desc "Run all tests"
task :default => :test 