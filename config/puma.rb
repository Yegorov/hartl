workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload.app!

rackup DefaultRackup
port ENV['PORT'] || 3000
evironment ENV['RACK_ENV'] || 'development'

on_work_boot do
  # for rails 4.1+
  ActiveRecord::Base.establish_connection
end