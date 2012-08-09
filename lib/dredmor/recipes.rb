#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dredmor/recipes/recipe'
require 'dredmor/recipes/craft'
require 'dredmor/recipes/encrust'

class Dredmor

class Recipes
	include Enumerable

	attr_reader :game

	def initialize (game)
		@game  = game
		@tools = Hash.new { |h,k| h[k] = [] }

		if xml = game.read_xml('craftDB')
			xml.xpath('//craft').each {|xml|
				@tools[xml.at('tool')[:tag].to_sym] << Craft.new(game, xml)
			}
		end

		if xml = game.read_xml('encrustDB')
			xml.xpath('//encrust').each {|xml|
				@tools[xml.at('tool')[:tag].to_sym] << Encrust.new(game, xml)
			}
		end
	end

	def each (name = nil, &block)
		return enum_for :each, name unless block

		if name
			@tools[name].each(&block)
		else
			@tools.each_value {|recipe|
				recipe.each(&block)
			}
		end

		self
	end

	def recipe_for (name)
		find { |c| c.result.name == recipe }
	end
end

end
