#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dredmor/crafts/craft'

class Dredmor

class Crafts
	include Enumerable

	attr_reader :game

	def initialize (game)
		@game  = game
		@tools = Hash.new { |h,k| h[k] = [] }

		game.read_xml('craftDB').xpath('//craft').each {|xml|
			@tools[xml.at('tool')[:tag].to_sym] << Craft.new(game, xml)
		}
	end

	def each (name = nil, &block)
		return enum_for :each, name unless block

		if name
			@tools[name].each(&block)
		else
			@tools.each_value {|crafts|
				crafts.each(&block)
			}
		end

		self
	end
end

end
