#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Skills

class Inventory
	attr_reader :game, :skill, :item, :amount

	def initialize (skill, xml)
		@game  = skill.game
		@skill = skill

		@always = xml[:always] == '1'
		@item   = game.items[xml[:subtype]]
		@amount = (xml[:amount] || 1).to_i
	end

	def always?
		@always
	end

	def inspect
		"#<Dredmor::Skill::Inventory(#{item.inspect}): #{always? ? 'always' : 'sometimes'} #{amount}>"
	end
end

end

end
