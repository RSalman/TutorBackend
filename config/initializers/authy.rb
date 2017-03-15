require 'authy'

Authy.api_key = ENV['AUTHY_API_KEY'] || "bf12974d70818a08199d17d5e2bae630"
Authy.api_uri = ENV['AUTHY_API_URL'] || "http://sandbox-api.authy.com"
