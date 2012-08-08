#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Items

class Food < Item
	Heals = Struct.new(:health, :mana)

	attr_reader :heals, :effect

	def initialize (game, xml)
		super

		@heals = Heals.new(xml.at('food')[:hp].to_i, xml.at('food')[:mp].to_i).freeze
		@vegan = xml.at('food')[:meat] != '1'

		if effect = xml.at('food')[:effect]
			@effect = game.spells[effect]
		end
	end

	def vegan?
		@vegan
	end
end

end; end
