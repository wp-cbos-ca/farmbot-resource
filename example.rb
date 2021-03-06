require_relative './lib/farmbot-resource'
require 'pry'
token = FbResource::Client.get_token(email: 'admin@admin.com',
                                     password: 'password123',
                                     # Defaults to "my.farmbot.io" if not specified.
                                     url: "http://localhost:3000")

client = FbResource::Client.new do |config|
  # Note for users that self host a Farmbot API:
  # FbResource will grab the URL from the token's "ISS" claim.
  config.token = token
end

puts("Grabbing schedules")
puts client.schedules.all.to_s
puts("Grabbing plants")
puts client.plants.all.to_s
puts("Grabbing sequences")
puts client.sequences.all.to_s
puts("Grabbing devices")
puts client.device.current.to_s
puts "Grabbing public key"
puts client.public_key.to_pem
puts "Done using email/password. Attempting with credentials file now."
# Just a fake credentials file, as generated by Farmbot.
example = File.read("example_credentials.txt")
# An alternative means of generating a token without a password.
alt_token = FbResource::Client.get_token(credentials: example,
                                         url: "http://localhost:3000")
alt_client = FbResource::Client.new do |config|
 # Note for users that self host a Farmbot API:
 # FbResource will grab the URL from the token's "ISS" claim.
 config.token = token
end
puts("Grabbing devices with credentials")
puts client.device.current.to_s
puts "Grabbing public key with credentials"
puts client.public_key.to_pem
