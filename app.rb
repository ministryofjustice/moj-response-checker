require 'sinatra'
require 'responsechecker'

SITES = [
  ['Prison Visits Booking', 'https://www.prisonvisits.service.gov.uk/prisoner-details'],
  ['People Finder', 'https://people-finder.dsd.io/sessions/new'],
  ['MoJ Website', 'http://www.justice.gov.uk/' ]
]

def checks
  SITES.map do |name, url|
    checker = ResponseChecker::Checker.new_with_all_checks(url)
    [name, url, checker.perform_checks]
  end
end

get '/' do
  @checks = checks
  haml :index
end

get '/style.css' do
  scss :style
end
