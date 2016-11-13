require "nokogiri"
require "net/https"

STDOUT.sync = !$stdout.tty?

def check_url(url, method: Net::HTTP::Head)
  uri = URI(url)

  opts = {
    open_timeout: 3,
    read_timeout: 3,
    use_ssl:      uri.scheme == "https",
    verify_mode:  OpenSSL::SSL::VERIFY_PEER,
  }

  Net::HTTP.start(uri.host, uri.port, opts) do |http|
    case resp = http.request(method.new(uri))
    when Net::HTTPRedirection
      check_redirect(uri, resp)
    when Net::HTTPNotFound, Net::HTTPMethodNotAllowed
      if method == Net::HTTP::Head
        check_url(uri, method: Net::HTTP::Get)
      else
        puts "#{resp.code}: #{uri}"
      end
    else
      puts "#{resp.code}: #{uri}"
    end
  end
rescue Net::OpenTimeout, Net::ReadTimeout
  puts "TIMEOUT: #{uri}"
rescue StandardError => e
  puts "ERROR: #{uri}\n  #{e.message}"
end

def check_redirect(uri, resp)
  loc = resp.fetch("location")
  puts "#{resp.code}: #{uri} -> #{loc}"
  new_uri = URI.join(uri, loc)
  if new_uri == uri
    puts "ERROR: skipping self-redirect"
  else
    check_url new_uri
  end
end

Nokogiri::HTML(ARGF).css("a").each { |link| check_url link["href"] }
