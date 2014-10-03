require 'sinatra'
require 'responsechecker'

SITES = [
  'https://www.prisonvisits.service.gov.uk/prisoner-details',
  'https://people-finder.dsd.io/sessions/new',
  'http://www.justice.gov.uk/',
  'http://ajtc.justice.gov.uk/',
  'http://azellerodneyinquiry.independent.gov.uk/',
  'http://blogs.justice.gov.uk/',
  'http://blogs.justice.gov.uk/cjg/',
  'http://blogs.justice.gov.uk/digital/',
  'http://blogs.justice.gov.uk/opgtransformation/',
  'http://callmeback.justice.gov.uk/',
  'http://cases.civillegaladvice.service.gov.uk/',
  'http://civil-eligibility-calculator.justice.gov.uk/',
  'http://cjsm.justice.gov.uk/',
  'http://courttribunalfinder.service.gov.uk/',
  'http://courttribunalformfinder.service.gov.uk/',
  'http://dugganinquest.independent.gov.uk/',
  'http://employmenttribunals.service.gov.uk/',
  'http://find-legal-advice.justice.gov.uk/',
  'http://globallawsummit.com/',
  'http://hillsboroughinquests.independent.gov.uk/',
  'http://jac.judiciary.gov.uk/',
  'http://judicialconduct.judiciary.gov.uk/',
  'http://lawcommission.justice.gov.uk/',
  'http://legal-aid-checker.justice.gov.uk/',
  'http://one3one.justice.gov.uk/',
  'http://open.justice.gov.uk/',
  'http://ppo.gov.uk/',
  'http://probatesearch.service.gov.uk/',
  'http://sentencingcouncil.judiciary.gov.uk/',
  'http://trackparliamentaryquestions.service.gov.uk/',
  'http://tribunalsdecisions.service.gov.uk/',
  'http://victimservices.justice.gov.uk/',
  'http://webchat.justice.gov.uk/',
  'http://www.cjsm.justice.gov.uk/',
  'http://www.employmenttribunals.service.gov.uk/',
  'http://www.justice.gov.uk/',
  'http://www.justice.gov.uk/about/imb',
  'http://www.justice.gov.uk/youth-justice/publications',
  'http://www.lastingpowerofattorney.service.gov.uk/',
  'http://www.makeaplea.justice.gov.uk/',
  'http://www.prisonvisits.service.gov.uk/',
  'http://www.prisonvisits.service.gov.uk/prisoner-details',
  #'http://yjbdep.justice.gov.uk/',
  #'http://yjbpublications.justice.gov.uk/',
  #'http://yjbpublications.justice.gov.uk/en-gb/'
]

def checks
  SITES.map do |url|
    checker = ResponseChecker::Checker.new_with_all_checks(url)
    [url, checker.perform_checks]
  end
end

get '/' do
  @checks = checks
  haml :index
end

get '/style.css' do
  scss :style
end
