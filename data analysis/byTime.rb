# !/usr/bin/env ruby
# encoding: utf-8
Dir.chdir(File.dirname(__FILE__))

require 'json'
require 'awesome_print'
require 'nokogiri'
require 'csv'
require 'date'

file = File.read('mails.json')
mails = JSON.parse(file)

def countWords (arr)
	words = {}
	arr.each do |mail|
		unless mail.nil? || mail['nouns'].nil?
			mail['nouns'].each do |_word, count|
				word = _word.gsub(/\n/, "").gsub(/ /, "").gsub(/\s/, '').strip.gsub(/^\./, "").gsub(/\.$/, "")
				if words.key? word
					words[word] += count
				else
					words[word] = count
				end
			end
		end
	end
	words.sort_by { |word, count| -1 * count }.to_h
end

months = mails.group_by do |mail|
	# ap Date.strptime(mail['date'])
	date = Date.strptime(mail['date'])
	"#{date.year}-#{date.month}-#{date.cweek}"
end

words_by_month = months.map do |month, list|
	# ap list
	ap month
	[month, countWords(list)]
end.to_h

# ap words_by_month

File.open('words_by_month.json', 'w') do |f|
  f.write(JSON.pretty_generate(words_by_month))
end