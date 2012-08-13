#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Texts

class Noun < Text
	attr_reader :plural, :statue, :floor, :painting

	def initialize (game, xml)
		super(game, xml[:text])

		@plural = xml[:plural].freeze

		@statue   = game.read_sprite xml[:statue]
		@floor    = game.read_sprite xml[:floor]
		@painting = game.read_sprite xml[:painting]
	end

	alias singular to_s
end

end; end
