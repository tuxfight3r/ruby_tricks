#!/usr/bin/ruby
#Author: Mohan
#Purpose: To update local gitrepo if its not in sync with remote repo
#Date: 10/01/2014

require "net/https"
require "uri"
require "json"

repo_url="https://api.github.com/repos/github/hubot-scripts/git/refs/heads/master"

uri = URI.parse(repo_url)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
#parse the above http response as JSON input
commitid_hash = JSON.parse(response.body)
commitid="#{commitid_hash['object']['sha']}"

puts "remote_commitid: #{commitid}"
local_commitid=`cd hubot-scripts;git rev-parse HEAD`.chop
puts "local_commitid : #{local_commitid}"
#puts response.code
if commitid != local_commitid then
  puts "Local Repository OutofDate - Pulling New Files"
  #system ("cd hubot-scripts;git pull");
else
   puts "Repos are in Sync, Exiting.."
end
