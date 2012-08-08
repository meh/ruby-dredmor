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

class Trap < Item
	Origin = Struct.new(:trap, :icon, :facing, :mount)

	attr_reader :level, :effect

	def initialize (game, xml)
		super

		@level  = xml[:level].to_i
		@once   = xml.at('trap')[:trigger] == 'once'
		@effect = game.spells[xml.at('trap')[:casts]]

		if origin = xml.at('trap')[:origin]
			@origin = Origin.new(self, game.read_icon(origin),
				(xml.at('trap')[:facing].to_sym rescue nil),
				(xml.at('trap')[:mount].to_sym rescue nil)
			)
		end
	end

	def once?
		@once
	end

	def always?
		!once?
	end
end

end; end
