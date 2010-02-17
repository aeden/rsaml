require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'

require File.join(File.dirname(__FILE__), '/lib/rsaml/version')

PKG_BUILD       = ENV['PKG_BUILD'] ? '.' + ENV['PKG_BUILD'] : ''
PKG_NAME        = 'rsaml'
PKG_VERSION     = RSAML::VERSION::STRING + PKG_BUILD
PKG_FILE_NAME   = "#{PKG_NAME}-#{PKG_VERSION}"
PKG_DESTINATION = ENV["PKG_DESTINATION"] || "../#{PKG_NAME}"

RELEASE_NAME  = "REL #{PKG_VERSION}"
PKG_FILES = FileList[
  #'CHANGELOG',
  #'LICENSE',
  'README',
  #'TODO',
  'Rakefile',
  'bin/**/*',
  'doc/**/*',
  'lib/**/*',
] - [ 'test' ]

spec = Gem::Specification.new do |s|
  s.name = 'rsaml'
  s.version = PKG_VERSION
  s.summary = "RSAML - SAML implementation in Ruby."
  s.description = <<-EOF
    An implementation of SAML in Ruby.
  EOF

  s.add_dependency('rake', '>= 0.7.1')
  s.add_dependency('uuid', '>= 1.0.4')

  s.rdoc_options << '--exclude' << '.'
  s.has_rdoc = false

  s.files = PKG_FILES.to_a.delete_if {|f| f.include?('.svn')}
  s.require_path = 'lib'

  s.author = "Anthony Eden"
  s.email = "anthonyeden@gmail.com"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "scashin133-rsaml"
    gemspec.summary = "Ruby implementation of the SAML 2.0 Specification"
    gemspec.description = %Q{RSAML is a SAML implementation in Ruby. RSAML currently implements the elements defined in the SAML-Core 2.0 
    specification by defining an object model that mimics the structure of SAML. Method names and attributes have been made 
    ruby-friendly and documentation is provided for each class and method. In certain cases the SAML specification is 
    referenced directly and should be considered the final say whenever a question arises regarding SAML implementation.
    }
    gemspec.email = ["anthonyeden@gmail.com", "scashin133@gmail.com"]
    gemspec.homepage = "http://github.com/scashin133/rsaml"
    gemspec.authors = ["Anthony Eden"]
    gemspec.add_dependency('activesupport', '>=2.3.4')
    gemspec.add_dependency('uuid', '>=2.1.1')
    gemspec.version = PKG_VERSION
    gemspec.files = PKG_FILES.to_a.delete_if {|f| f.include?('.svn')}
    gemspec.require_path = 'lib'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available.  Install it with: gem install jeweler"
end


desc 'Default: run unit tests.'
task :default => :test

desc 'Test the library.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  test_files = FileList['test/**/*_test.rb']
  t.test_files = test_files
  t.verbose = true
end

desc 'Generate documentation for the library.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'RSAML'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :rcov do
  desc 'Measures test coverage'
  task :test do
    rm_f 'coverage.data'
    mkdir 'coverage' unless File.exist?('coverage')
    rcov = "rcov --aggregate coverage.data --text-summary -Ilib"
    system("#{rcov} test/*_test.rb")
    #system("open coverage/index.html") if PLATFORM['darwin']
  end
end

desc "Generate code statistics"
task :lines do
  lines, codelines, total_lines, total_codelines = 0, 0, 0, 0

  for file_name in FileList["lib/**/*.rb"]
    next if file_name =~ /vendor/
    f = File.open(file_name)

    while line = f.gets
      lines += 1
      next if line =~ /^\s*$/
      next if line =~ /^\s*#/
      codelines += 1
    end
    puts "L: #{sprintf("%4d", lines)}, LOC #{sprintf("%4d", codelines)} | #{file_name}"
    
    total_lines     += lines
    total_codelines += codelines
    
    lines, codelines = 0, 0
  end

  puts "Total: Lines #{total_lines}, LOC #{total_codelines}"
end

desc "Reinstall the gem from a local package copy"
task :reinstall => [:package] do
  windows = RUBY_PLATFORM =~ /mswin/
  sudo = windows ? '' : 'sudo'
  gem = windows ? 'gem.bat' : 'gem'
  `#{sudo} #{gem} uninstall -x -i #{PKG_NAME}`
  `#{sudo} #{gem} install pkg/#{PKG_NAME}-#{PKG_VERSION}`
end