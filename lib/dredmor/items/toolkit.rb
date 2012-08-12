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

class Toolkit < Item
	attr_reader :type

	def initialize (game, xml)
		super

		@type = xml.at('toolkit')[:tag].to_sym
	end

	def craft (&block)
		game.recipes!.crafts.each(type, &block)
	end

	def encrusts (&block)
		game.recipes!.encrusts.each(type, &block)
	end
end

end; end
