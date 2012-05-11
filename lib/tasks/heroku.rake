namespace :heroku do
  desc "Send application settings to Heroku"
  task :config do
    puts "Reading config/setting.yml and sending config vars to Heroku..."

    CONFIG = YAML.load_file('config/settings.yml')['production'] rescue {}
    command = "heroku config:add"

    CONFIG.each {|key, val| command << " '#{key}=#{val}' " if val }

    puts command
  end
end