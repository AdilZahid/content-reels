# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :application, "contentreels"
set :repo_url, "git@gitlab.vteamslabs.com:vteams/contentreels.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/apps/contentreels"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true
# set :use_sudo, false
set :linked_files, fetch(:linked_files, [])
                     .push(
                       'config/database.yml',
                       'config/master.key',
                       'config/credentials.yml.enc',
                       'config/puma.rb'
                     )

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
set :linked_dirs, fetch(:linked_dirs, [])
                    .push(
                      'log',
                      'tmp/pids',
                      'tmp/cache',
                      'tmp/sockets',
                      'public/system',
                      'storage'
                    )

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5


set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_conf, "#{shared_path}/config/puma.rb"

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
before 'deploy:starting', 'config_files:upload'
