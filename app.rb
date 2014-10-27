require 'sinatra'
require 'open-uri'
require 'json'

def checks
  f = open('https://s3-eu-west-1.amazonaws.com/opsreports/index.json')
  JSON.parse(f.read).each.map do |url, data|
    if data['response_checks']
      check_data = data['response_checks']['checks'].map do |check_hash|
        check_hash.values_at('name', 'description', 'result')
      end
      [url, check_data]
    end
  end.compact
end

def sorted_checks
  checks.sort_by do |url, check_data|
    check_data.select { |_, _, result| !!result }.count
  end
end

get '/' do
  @headers = [
    'X-Content-Type-Options',
    'X-Frame-Options',
    'HttpOnly cookies',
    'Secure cookies',
    'Strict transport security',
    'X-XSS-Protection'
  ]
  @checks = sorted_checks.reverse
  haml :index
end

get '/style.css' do
  scss :style
end
