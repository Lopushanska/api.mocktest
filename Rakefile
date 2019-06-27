require 'rest-client'
require 'yaml'

config = YAML.load_file("#{Dir.pwd}/config.yml")

desc 'Rake task to run tests sequentially in 3 browsers with around run cleanups of demo data'
task :run_sequentially do
  started_at = Time.now
  puts "[35m Started At #{started_at} [0m"

  sh "rake run_in_browsers['chrome, firefox, safari']" do
    #ignore errors
  end

  finished_at = Time.now
  run_took = Time.at(finished_at - started_at).utc.strftime('%H:%M:%S')
  puts "[35m End at #{finished_at} [0m"
  puts "[35m Run took #{run_took} [0m"
end

desc 'Rake task to run tests in parallel in 3 browsers with around run cleanups of demo data'
task :run_parallel do
  started_at = Time.now
  puts "[35m Started At #{started_at} [0m"

  t1 = Thread.new{sh "rake cucumber_simple_run[chrome]"}
  t2 = Thread.new{sh "rake cucumber_simple_run[firefox]"}
  t3 = Thread.new{sh "rake cucumber_simple_run[safari]"}
  t1.join
  t2.join
  t3.join

  finished_at = Time.now
  run_took = Time.at(finished_at - started_at).utc.strftime('%H:%M:%S')
  puts "[35m End at #{finished_at} [0m"
  puts "[35m Run took #{run_took} [0m"
end

desc 'Rake task to run tests sequentially in different browsers without any reporting options'
task :run_in_browsers, :browser_1, :browser_2, :browser_3 do |task, args|
  if "#{args[:browser_1]}".empty? && "#{args[:browser_2]}".empty? && "#{args[:browser_3]}".empty?
    puts 'Please specify in what browsers you would like to run tests, e.g. ["chrome, firefox, safari"]'
  else

    unless "#{args[:browser_1]}".empty?
      sh "rake cucumber_simple_run[#{args[:browser_1]}]" do
        #ignore errors
      end
    end

    unless "#{args[:browser_2]}".empty?
      sh "rake cucumber_simple_run[#{args[:browser_2]}]" do
        #ignore errors
      end
    end

    unless "#{args[:browser_3]}".empty?
      sh "rake cucumber_simple_run[#{args[:browser_3]}]" do
        #ignore errors
      end
    end
  end
end

desc 'Simple Cucumber run without any reporting options'
task :cucumber_simple_run, :browser do |task, args|
  ENV['browser'] = args[:browser]

  sh "cucumber" do
    #ignore errors
  end
end