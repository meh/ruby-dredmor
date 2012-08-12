#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class TextDatabase

class Text
	attr_reader :game

	def initialize (game, string)
		@game  = game
		@value = string.freeze
	end

	def to_s
		@value
	end

	alias to_str to_s
end

end; end
