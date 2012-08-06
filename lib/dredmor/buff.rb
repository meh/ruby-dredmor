#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dredmor/buff/primary'
require 'dredmor/buff/secondary'
require 'dredmor/buff/damage'
require 'dredmor/buff/resistance'

class Dredmor

class Buff
	def self.new (game, xml)
		return super unless self == Buff

		case xml.name.downcase
		when 'primarybuff'   then Primary.new(game, xml)
		when 'secondarybuff' then Secondary.new(game, xml)
		when 'damagebuff'    then Damage.new(game, xml)
		when 'resistbuff'    then Resistance.new(game, xml)
		else raise ArgumentError, "#{xml.name} is an unknown buff"
		end
	end
end

end
