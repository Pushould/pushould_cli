require "pushould/version"
require "pushould/cli"

module Pushould
  class Client
    attr_reader :url, :token, :email, :password

    def initialize(_url, token, _email, _password)
      @url = _url
      @token = token
      @email = _email
      @password = _password
    end

    def trigger(room: _room, event: _event, data: _data)
      account_info = { email: @email, password: @password }.to_json
      data = { room: room,
               event: event,
               token: @token,
               custom: data
             }.to_json
      RestClient::Resource.new(@url, verify_ssl: OpenSSL::SSL::VERIFY_NONE).get(params: { account: account_info, data: data }, content_type: 'application/json', accept: 'application/json')
    end
  end

  def self.new(args = {})
    raise ArgumentError if args[:url].nil?
    raise ArgumentError if args[:server_token].nil?
    raise ArgumentError if args[:email].nil?
    raise ArgumentError if args[:password].nil?

    Pushould::Client.new(args[:url], args[:server_token], args[:email], args[:password])
  end
end
