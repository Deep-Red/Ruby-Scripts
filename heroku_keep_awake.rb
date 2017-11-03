require 'net/http'

uri = URI('https://calm-fjord-65774.herokuapp.com/users/sign_in')


loop do
  t = Time.now

  Net::HTTP.start(uri.host, uri.port, :use_ssl => true) {|http|
    request = Net::HTTP::Get.new uri
    response = http.request request
    puts "#{response.code} at #{Time.now.strftime("%H:%M:%S")}"
  }

  sleep (t + 600 - Time.now)
end
