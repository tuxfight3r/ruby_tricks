#!/usr/bin/ruby
require "net/https"
require "uri"

uri = URI.parse("https://github.com/github/hubot-scripts")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
commitid=response.body.grep(/latest/).grep(/href/)
commitid.to_s =~ /.*?\/commit\/(.*?)\".*/
commitid=$1

puts "ext_commitid: #{commitid}"
local_commitid=`cd hubot-scripts;git rev-parse HEAD`.chop
puts "lcl_commitid: #{local_commitid}"
#puts response.code
if commitid != local_commitid then
  puts "Local Repo OutofDate - Pulling New Files"
  #system ("cd hubot-scripts;git pull");
else
   puts "Repos are in Sync, Exiting.."
end
