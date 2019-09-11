# !/usr/bin/env ruby
# encoding: utf-8
Dir.chdir(File.dirname(__FILE__))

require 'json'
require 'awesome_print'
require 'nokogiri'
require 'csv'

def writeCSV (file, obj)
	CSV.open("#{file}.csv", "w") do |csv|
		csv << ['date', 'from', 'subject', 'text']
		obj.each do |row|
			# ap row
			csv << row# if !row.nil? && (row.include?('http'))
		end
	end
end

file = File.read('mbox/geoengineering.json')
data_hash = JSON.parse(file)

links = []
images = []
mails = []

# ap data_hash.first(1)

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
			# links.push(*nodes.search('.//a'))
			break if (node.name.include?('comment'))
			images.push(*nodes.search('.//img'))
			# ap node.name
			mail.push(node.text)
			# ap node.to_s
		end
		text = mail.join(' ').gsub(/\n/, "").gsub(/\s+/, ' ').squeeze(' ').strip
		from = obj['from'][0]['address']
		date = obj['date']
		subject = obj['subject']
		mails.push([date, from, subject, text])
	end
	# ap obj['html'].nil?
	# ap obj['text'].nil? if obj['html'].nil?
	# puts Nokogiri::HTML(obj['html']).text
end

# hrefs = links.map do |link|
# 	# ap link['href']
# 	link['href']
# end

# srcs = images.map do |image|
# 	# ap image['href']
# 	image['src']
# end

# writeCSV("images", srcs)

writeCSV("mails", mails)