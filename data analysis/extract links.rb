# !/usr/bin/env ruby
# encoding: utf-8
Dir.chdir(File.dirname(__FILE__))

require 'json'
require 'awesome_print'
require 'nokogiri'
require 'csv'

def writeCSV (file, obj)
	CSV.open("#{file}.csv", "w") do |csv|
		obj.each do |row|
			# ap row
			csv << row unless row.nil?
		end
	end
end

file = File.read('mbox/geoengineering.json')
data_hash = JSON.parse(file)

links = []

data_hash.each do |obj|
	unless obj['html'].nil?
		# puts 'XXXX'
		relevant = []
		nodes = Nokogiri::HTML(obj['html']).css('body').children
		nodes.search('.//blockquote').remove
		nodes.search('.//comment').remove
		mail = []
		nodes.each do |node|
			# puts '––'
			break if (node.text.include?('You received'))
			break if (node.text.include?('This e-mail may contain confidential material'))
			break if (node.text.include?('To unsubscribe please'))
			break if (node.text.include?('Sent by a member'))
			break if (!node['class'].nil? && node['class'].include?('signature'))
			break if (node.name.include?('comment'))
			links.push(*nodes.search('.//a'))
		end
	end
end

hrefs = links.map do |link|
	begin
    unless (link['href'].nil?)
		url = link['href'].strip
		# ap url
		if url.ascii_only?
			[url, URI.parse(url).host]
		end
	end
  rescue
    next
  end
end

# writeCSV("images", srcs)

writeCSV("links", hrefs)