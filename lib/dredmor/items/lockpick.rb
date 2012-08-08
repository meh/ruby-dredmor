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

class Lockpick < Item
	def initialize (game)
		@game = game

		@name  = 'Lockpick'
		@price = 4
		@icon  = game.read_icon 'items/lockpick'
	end
end

end; end
