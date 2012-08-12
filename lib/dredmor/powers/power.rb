#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Powers

class Power
	attr_reader :game, :name, :description, :effect

	def initialize (game, xml)
		@game = game

		@name        = xml[:name]
		@description = xml[:description]
		@effect      = game.spells![xml[:spell]]
		@unstable    = xml.name == 'unstableEffect'
	end

	def unstable?
		@unstable
	end
end

end; end
