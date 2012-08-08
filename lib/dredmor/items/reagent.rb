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

class Reagent < Item
	def initialize (game, xml)
		super

		@in_vending_machines = xml[:alchemical] == '1'
	end

	def in_vending_machines?
		@in_vending_machines
	end
end

end; end
