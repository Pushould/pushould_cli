require "pushould"
require "rest-client"
require "thor"
require "json"

module Pushould
  class CLI < Thor
    desc "signin", "sign in to pushould.com"
    def signin
      account  = validate_account
      return puts "Error: #{account[:message]}" if account[:status] == 'error'
      email    = account[:email]
      password = account[:password]
      request  = RestClient::Resource.new("https://pushould.com/signin?email=#{email}&password=#{password}", OpenSSL::SSL::VERIFY_NONE)
      response = request.get(parms: { email: email, password: password })
      data     = JSON.parse(response)
      return puts "Error: #{data['error']}" if data['error']
      echo_data(data) if data['url'] && data['client_token'] && data['server_token']
    end

    desc "signup", "sign up to pushould.com"
    def signup
      account  = validate_account
      return puts "Error: #{account[:message]}" if account[:status] == 'error'
      email    = account[:email]
      password = account[:password]
      request  = RestClient::Resource.new("https://pushould.com/signup?email=#{email}&password=#{password}", OpenSSL::SSL::VERIFY_NONE)
      response = request.get(parms: { email: email, password: password })
      data     = JSON.parse(response)
      return puts "Error: #{data['error']}" if data['error']
      echo_data(data) if data['url'] && data['client_token'] && data['server_token']
    end

    desc "update", "update token on pushould.com"
    def update
      account  = validate_account
      return puts "Error: #{account[:message]}" if account[:status] == 'error'
      email    = account[:email]
      password = account[:password]
      request  = RestClient::Resource.new("https://pushould.com/update_token?email=#{email}&password=#{password}", OpenSSL::SSL::VERIFY_NONE)
      response = request.get(parms: { email: email, password: password })
      data     = JSON.parse(response)
      return puts "Error: #{data['error']}" if data['error']
      echo_data(data) if data['url'] && data['client_token'] && data['server_token']
    end

    private

    def send_request(request, email, password)
      response = request.get(params: { email: email, password: password })
      return JSON.parse(response)
    end

    def validate_account
      email = ask("Email: ")
      password = ask("Password (hidden) :", echo: false)
      puts "\n"
      return { status: 'error', message: 'email or password is invalid.' } if email == '' || password == ''
      return { status: 'success', email: email, password: password }
    end

    def echo_data(data)
      url = data['url']
      client_token = data['client_token']
      server_token = data['server_token']
      puts "\nurl:"
      puts "#{url}\n"

      puts "\nclient_token:"
      puts "#{client_token}\n"

      puts "\nserver_token:"
      puts "#{server_token}"
    end
  end
end
