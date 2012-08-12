#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dredmor/scrolls/scroll'

class Dredmor

class Scrolls
	include Enumerable

	attr_reader :game

	def initialize (game)
		@game    = game
		@scrolls = []

		if xml = game.read_xml('scrollDB')
			xml.xpath('//scroll').each {|xml|
				@scrolls << Scroll.new(game, xml)
			}
		end
	end

	def each (&block)
		@scrolls.each(&block)
	end

	def [] (name)
		find { |s| name === s.name }
	end
end

Scroll = Scrolls::Scroll

end
