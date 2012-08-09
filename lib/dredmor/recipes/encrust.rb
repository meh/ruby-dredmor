#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Crafts

class Encrust < Recipe
	include WithBuffs

	attr_reader :result, :required, :instability, :power

	def initialize (game, xml)
		super

		@required = Required.new(
			xml.css('input').map { |x| game.items.find { |i| i.name == x[:name] } },
			xml.at('skill')[:level].to_i
		)

		@instability = xml.at('instability')[:amount].to_i
		@power       = game.powers[xml.at('power')[:name]]

		if chance = xml.at('power')[:chance]
			@chance = (chance.to_f * 100).to_i
		else
			@chance = 100
		end
	end
end

end; end
