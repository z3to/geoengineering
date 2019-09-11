# !/usr/bin/env ruby
# encoding: utf-8
Dir.chdir(File.dirname(__FILE__))

require "csv"
require "awesome_print"

HEADER = ["size", "chmod", "path", "accessed", "modified", "changed", "created"]

def readCSV (file)
  CSV.read("#{file}.csv", { encoding: "UTF-8", headers: HEADER }).map { |d| d.to_hash }
end

def writeCSV (file, obj)
	CSV.open("#{file}.csv", "w") do |csv|
		csv << obj.first.keys
		obj.each do |row|
			csv << row.values
		end
	end
end

files = readCSV("files").map do |file|
	created = Time.at(file["created"].to_i).to_datetime
	{
		type: File.basename(file["path"], ".*"),
		created: created.iso8601,
		weekday: created.strftime('%A'),
		size: file["size"]
	}
end

puts files

writeCSV("output", files)

groups = files.group_by do |file|
	file[:weekday]
end.map do |key, values|
	size = values.map { |h| h[:size].to_i }.sum
	{
		key: key,
		count: values.length,
		size: size
	}
end

ap groups

writeCSV("output-groups", groups)
