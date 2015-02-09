env_var_file = File.join(::Rails.root, '.env')
if File.exists? env_var_file
  File.open(env_var_file).read.split("\n").each do |env_var|
    ENV[env_var.split('=')[0]] = env_var.split('=')[1]
  end
end

SITE_CONFIG = {}
SITE_CONFIG[:api_token_511] = ENV['API_TOKEN_511']
