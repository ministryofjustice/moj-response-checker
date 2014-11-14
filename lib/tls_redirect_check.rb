require 'net/http'

module TlsRedirectCheck
  class << self
    def perform(url)
      uri = URI(url)
      destination = destination_after_redirects(uri)
      ["HTTP => HTTPS redirect", nil, redirects_http_to_https?(destination)]
    end

    # Visits passed in URL and follows all redirects until we get a 200 response.
    # Returns the final URL
    def destination_after_redirects(uri)
      response = Net::HTTP.get_response(uri)
      case response.code
      when /\A3/
        destination_after_redirects(URI(response['location']))
      else
        uri
      end
    end

    def redirects_http_to_https?(uri)
      a, b = uri.clone, uri.clone
      a.scheme = 'http'
      b.scheme = 'https'

      a = URI(a.to_s)

      response = Net::HTTP.get_response(a)
      return false unless response.code =~ /\A3/

      b.to_s.chomp('/') == URI(response['location']).to_s.chomp('/')
    end
  end
end
