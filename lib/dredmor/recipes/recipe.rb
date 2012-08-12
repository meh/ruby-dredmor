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

class Recipe
	attr_reader :game, :toolkit, :name, :input, :output

	def initialize (game, xml)
		@game    = game
		@toolkit = game.items!.toolkits.find { |t| t.type == xml.at('tool')[:tag].to_sym }
		@secret  = xml[:hidden] == '1'
	end

	def secret?
		@secret
	end
end

end; end
