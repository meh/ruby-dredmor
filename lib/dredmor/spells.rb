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
require 'dredmor/spells/buff'
require 'dredmor/spells/effect'
require 'dredmor/spells/probability'

class Dredmor

class Spells
	include Enumerable

	attr_reader :game

	def initialize (game)
		@game   = game
		@spells = []

		if xml = game.read_xml('spellDB')
			xml.xpath('//spell').each {|xml|
				@spells << Spell.new(game, xml)
			}
		end
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
