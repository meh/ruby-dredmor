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

class Verb < Text
	attr_reader :past, :continuous

	def initialize (game, xml)
		super(game, xml[:text])

		@past       = xml[:past].freeze
		@continuous = xml[:continuous].freeze
	end

	alias present to_s
end

end; end
