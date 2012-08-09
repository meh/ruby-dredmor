#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dredmor/powers/power'

class Dredmor

class Powers
	include Enumerable

	attr_reader :game

	def initialize (game)
		@game   = game
		@powers = []

		if xml = game.read_xml('itemDB')
			xml.xpath('//power').each {|xml|
				@powers << Power.new(game, xml)
			}
		end

		if xml = game.read_xml('encrustDB')
			xml.xpath('//unstableEffect').each {|xml|
				@powers << Power.new(game, xml)
			}
		end
	end

	def each (&block)
		return to_enum unless block

		@powers.each(&block)

		self
	end

	def [] (name)
		find { |p| name === p.name }
	end
end

end
