require "nokogiri"
require "net/https"

def check_url url
  uri = URI(url)

  opts = {
    open_timeout: 3,
    read_timeout: 3,
    use_ssl:      uri.scheme == "https",
    verify_mode:  OpenSSL::SSL::VERIFY_PEER,
  }

  Net::HTTP.start(uri.host, uri.port, opts) do |http|
    case resp = http.request(Net::HTTP::Head.new(uri))
    when Net::HTTPRedirection
      check_redirect(uri, resp)
    else
      puts "#{resp.code}: #{uri}"
    end
  end
rescue Net::OpenTimeout, Net::ReadTimeout
  puts "TIMEOUT: #{uri}"
rescue StandardError => e
  puts "ERROR: #{uri}\n  #{e.message}"
end

def check_redirect uri, resp
  loc = resp.fetch("location")
  puts "#{resp.code}: #{uri} -> #{loc}"
  check_url URI.join(uri, loc)
end

Nokogiri::HTML(ARGF).css("a").each { |link| check_url link["href"] }
