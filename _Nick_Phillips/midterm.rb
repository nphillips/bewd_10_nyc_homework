require 'pry'
require 'rest-client'
gem 'twitter'
require 'twitter'

class TwitterSearch
	def initialize

		@client = Twitter::Streaming::Client.new do |config|
			config.consumer_key        = "FhmuzdXsyO0Dcmi2PHaEVMwyd"
			config.consumer_secret     = "HnYXHbEHvYK01OZQ7MY4bPpk4goNXz1Mp2treexAlQQRVswspX"
			config.access_token        = "4514751-s0utoCj0ppJ5a8lLUgIBp5KUFFDjKSRkBDbPW5TTJf"
			config.access_token_secret = "ru0cP8fyEWRd4nt7vFz0433lvTaNkec4TpAndNyHnKeDx"
		end
	end

	def search
		count = 5
		puts "\e[H\e[2J"
		puts "\n\n\n                               Hello & Welcome to:\n\n\n"
		puts "██╗     ██╗██╗   ██╗███████╗    ████████╗██╗    ██╗███████╗███████╗████████╗███████╗"
		puts "██║     ██║██║   ██║██╔════╝    ╚══██╔══╝██║    ██║██╔════╝██╔════╝╚══██╔══╝██╔════╝"
		puts "██║     ██║██║   ██║█████╗         ██║   ██║ █╗ ██║█████╗  █████╗     ██║   ███████╗"
		puts "██║     ██║╚██╗ ██╔╝██╔══╝         ██║   ██║███╗██║██╔══╝  ██╔══╝     ██║   ╚════██║"
		puts "███████╗██║ ╚████╔╝ ███████╗       ██║   ╚███╔███╔╝███████╗███████╗   ██║   ███████║"
		puts "╚══════╝╚═╝  ╚═══╝  ╚══════╝       ╚═╝    ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝\n\n"
		puts "Below, you'll enter a term that -- hopefully -- people are tweeting about RIGHT NOW!"
		puts "Once the program has found * #{count} * tweets mentioning your term, it will stop searching."
		puts "\nBeware! the less common your term, the longer you might have to wait! **It's LIVE!**"
		puts "\nENTER YOUR TERM:\n\n"
		keyword = $stdin.gets.chomp
puts "\n\n/-------------------------------------TWEETS----------------------------------------\\\n"

		topics = [keyword]

		@client.filter(:track => topics.join(",")) do |object|

			# binding.pry
			case object
			when Twitter::Tweet
				puts object.text 
			when Twitter::DirectMessage
				puts "It's a direct message!"
			when Twitter::Streaming::StallWarning
				warn "Falling behind!"
			else
				puts object
			end

			count -= 1

			break if count == 0

		end
	end

	MAX_ATTEMPTS = 20

	def try
		num_attempts = 0
		begin
			num_attempts += 1
			search

		rescue Twitter::Error::TooManyRequests => error
			if num_attempts <= MAX_ATTEMPTS
				sleep error.rate_limit.reset_in
				retry
			else
				raise
			end
		end

	rescue
	end
end

searcher = TwitterSearch.new
searcher.try
puts "\\-------------------------------------^^^^^^----------------------------------------/\n\n"
puts "\n(NOTE: Due to Twitter's API limitations, if you search OFTEN within a short timeframe," 
puts "you might see no results. In that case, please wait about 30 seconds before retrying).\n\n\n" 




