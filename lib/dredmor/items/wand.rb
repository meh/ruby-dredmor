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

class Wand < Item
	attr_reader :charges, :effect

	def initialize (game, xml)
		super

		@charges = Range.new(xml.at('wand')[:mincharge].to_i, xml.at('wand')[:maxcharge].to_i)
		@effect  = game.spells[xml.at('wand')[:spell]]
	end
end

end; end
