app_path = '/srv/apps/got.smile-team.info'

working_directory File.join(app_path, 'current')
pid File.join(app_path, 'shared/pids/unicorn.pid')
stderr_path File.join(app_path, 'shared/log/unicorn.log')
stdout_path File.join(app_path, 'shared/log/unicorn.log')

listen File.join(app_path, 'tmp/unicorn.sock'), backlog: 64
worker_processes 2
timeout 30
preload_app true

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  sleep 1
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end
