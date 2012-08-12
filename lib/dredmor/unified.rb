#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor

class Unified
	autoload :Items, 'dredmor/unified/items'
	autoload :Powers, 'dredmor/unified/powers'
	autoload :Recipes, 'dredmor/unified/recipes'
	autoload :Monsters, 'dredmor/unified/monsters'
	autoload :Skills, 'dredmor/unified/skills'
	autoload :Spells, 'dredmor/unified/spells'
	autoload :TargetAreas, 'dredmor/unified/target_areas'
	autoload :TextDatabase, 'dredmor/unified/text_database'
	autoload :Scrolls, 'dredmor/unified/scrolls'

	attr_reader :game

	def initialize (game)
		@game = game
	end
end

end
