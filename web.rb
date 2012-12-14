# Copyright 2012 James Jefferies
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
#
require 'sinatra'
require 'twitter'
require 'net/http'
require "uri"

# if you are using twilio, this is the URL path you want to post to...
# you can obviously change this to whatever you like
post '/postpath' do

  # If you are using gofreerange's back end server, then this should be 
  # the URL shortcut alias you have setup - you will replace exampleprintername
  # with your printer name
	uri = URI.parse("http://printer-mail.herokuapp.com/send/exampleprintername")
	http = Net::HTTP.new(uri.host, uri.port)

	request = Net::HTTP::Post.new(uri.request_uri)
  # IF you are using twilio, you can use the actual phone number from the message
  # or replace it with something generic
	request.set_form_data({'message[body]' => params['Body'], 'message[from]' => "FromSomebody"})
	puts params['Body'] 

	response = http.request(request)
  
  Twitter.reset
	Twitter.configure do |config|
    # Ensure these are set in your environment so that you can tweet the message 
    # to the relevant account
		config.consumer_key = ENV['C_CONSUMER_KEY']
		config.consumer_secret = ENV['C_CONSUMER_SECRET']
		config.oauth_token = ENV['C_OAUTH_TOKEN']
		config.oauth_token_secret = ENV['C_OAUTH_TOKEN_SECRET']
	end

  Twitter.update(params['Body'])

  # Send response back to twilio with empty message
  content_type 'text/xml'
  "<?xml version='1.0' encoding='UTF-8'?><Response></Response>"
end
