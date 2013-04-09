working_directory "/srv/http/got.smile-team.info/current"
pid "/srv/http/got.smile-team.info/shared/pids/unicorn.pid"
stderr_path "/srv/http/got.smile-team.info/shared/log/unicorn.stderr.log"
stdout_path "/srv/http/got.smile-team.info/shared/log/unicorn.stdout.log"

listen "/srv/http/got.smile-team.info/current/tmp/sockets/spreel.sock", backlog: 64
worker_processes 2
timeout 30
preload_app true


before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "/srv/http/got.smile-team.info/current/Gemfile"
end


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