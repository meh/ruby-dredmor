#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Recipes

class Encrust < Recipe
	attr_reader :description

	def initialize (game, xml)
		super

		@name        = xml[:name]
		@description = xml.at('description')[:text]

		@output = Output.new(self, xml)
		@input  = xml.css('input').map { |x| game.items![x[:name]] }
	end

	class Output
		include WithBuffs

		attr_reader :game, :recipe, :inscription, :required_level

		def initialize (recipe, xml)
			@game   = recipe.game
			@recipe = recipe

			@inscription = xml.at('encrustwith')[:name]
			@required_level = xml.at('skill')[:level].to_i
			@instability    = xml.at('instability')[:amount].to_i

			if power = xml.at('power')
				@power = game.powers![power[:name]]

				if chance = power[:chance]
					@chance = (chance.to_f * 100).to_i
				else
					@chance = 100
				end
			end

			from_xml(xml)
		end
	end
end

end; end
