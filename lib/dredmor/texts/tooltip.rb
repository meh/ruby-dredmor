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

class Tooltip < Text
	attr_reader :panel, :name

	def initialize (game, xml)
		super(game, xml[:text])

		@panel = xml[:panel].to_sym
		@name  = xml[:name]
	end
end

end; end
