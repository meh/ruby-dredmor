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

class Ability
	attr_reader :game, :skill, :level, :name, :description, :icon, :spells, :buffs, :on_hit, :on_kill

	def initialize (skill, xml)
		@game  = skill.game
		@skill = skill

		@level       = xml[:level].to_i
		@name        = xml[:name]
		@description = xml.xpath('.//description[1]/@text').first.value

		@icon = Icon.load(game, xml[:icon])

		@buffs   = []
		@spells  = []
		@on_hit  = []
		@on_kill = []

		xml.elements.each {|element|
			case element.name
			when 'spell'
				@spells << game.spells[element[:name]]

			when 'primarybuff', 'secondarybuff', 'resistbuff', 'damagebuff'
				@buffs << Buff.new(game, element)

			when 'targetHitEffectBuff'
				@on_hit << Spells::Probability.new(game.spells[element[:name]], element[:percentage].to_i)

			when 'targetKillBuff'
				@on_kill << Spells::Probability.new(game.spells[element[:name]], element[:percentage].to_i)

			end
		}
	end

	def inspect
		"#<Dredmor::Ability(#{name}): #{description.inspect}>"
	end
end

end; end
