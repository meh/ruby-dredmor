#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dredmor/spells/spell'
require 'dredmor/spells/probability'

class Dredmor

class Spells
	include Enumerable

	attr_reader :game

	def initialize (game)
		@game   = game
		@spells = []

		game.read_xml('spellDB').xpath('//spell').each {|xml|
			@spells << Spell.new(game, xml)
		}
	end

	def each (&block)
		@spells.each(&block)
	end

	def [] (name)
		find { |s| name === s.name }
	end
end

Spell = Spells::Spell

end
