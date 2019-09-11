# !/usr/bin/env ruby
# encoding: utf-8
Dir.chdir(File.dirname(__FILE__))

require "csv"
require "awesome_print"
require 'engtagger'
require 'json'

tgr = EngTagger.new

def readCSV (file)
  CSV.read("#{file}.csv", { encoding: "UTF-8", headers: true }).map { |d| d.to_hash }
end

def writeCSV (file, obj)
	CSV.open("#{file}.csv", "w") do |csv|
		csv << ['word', 'count']
		obj.each do |word, count|
			csv << [word, count]
		end
	end
end

def countWords (arr)
	words = {}
	arr.each do |list|
		unless list.nil?
			list.each do |_word, count|
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

allWords = []

mails = readCSV("mails").map do |file|
	tagged = tgr.add_tags(file['text'].downcase)
	nouns = tgr.get_nouns(tagged)
	allWords.push(nouns)
	{
		'date' => file['date'],
		'from' => file['from'],
		'subject' => file['subject'],
		'nouns' => nouns,
		'text' => file['text']
	}
end

writeCSV('most-used-words-2', countWords(allWords))

File.open('mails.json', 'w') do |f|
  f.write(JSON.pretty_generate(mails))
end