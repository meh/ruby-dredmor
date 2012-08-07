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
	attr_reader :game, :skill, :level, :name, :description, :icon, :spells, :buffs

	attr_reader :on_target_hit, :on_target_kill, :on_player_hit, :on_crossbow_shot, :on_thrown,
	            :on_cast, :on_dodge, :on_booze, :on_food, :on_consume, :on_critical, :on_counter,
	            :on_block

	def initialize (skill, xml)
		@game  = skill.game
		@skill = skill

		@level       = xml[:level].to_i
		@name        = xml[:name]
		@description = xml.at('description')[:text]

		@icon = game.read_icon xml[:icon]

		@buffs  = []
		@spells = []

		@on_target_hit    = []
		@on_target_kill   = []
		@on_player_hit    = []
		@on_crossbow_shot = []
		@on_thrown        = []
		@on_cast          = []
		@on_dodge         = []
		@on_booze         = []
		@on_food          = []
		@on_consume       = []
		@on_critical      = []
		@on_counter       = []
		@on_block         = []

		xml.elements.each {|element|
			case element.name
			when 'spell'
				@spells << game.spells[element[:name]]

			when 'primarybuff', 'secondarybuff', 'resistbuff', 'damagebuff'
				@buffs << Buff.new(game, element)

			when 'targetHitEffectBuff', 'targetKillBuff', 'playerHitEffectBuff', 'crossbowShotBuff',
			     'thrownBuff', 'triggerOnCast', 'dodgeBuff', 'boozeBuff', 'foodBuff', 'consumeBuff',
			     'criticalBuff', 'counterBuff', 'blockBuff'
				on(element.name) << Spells::Probability.new(game.spells[element[:name]], element[:percentage].to_i)
			end
		}
	end

	def on (what)
		case what.to_sym
		when :targetHitEffectBuff, :target_hit then @on_target_hit
		when :targetKillBuff, :target_kill     then @on_target_kill
		when :playerHitEffectBuff, :player_hit then @on_player_hit
		when :crossbowShotBuff, :crossbow_shot then @on_crossbow_shot
		when :thrownBuff, :thrown              then @on_thrown
		when :triggerOnCast, :cast             then @on_cast
		when :dodgeBuff, :dodge                then @on_dodge
		when :boozeBuff, :booze                then @on_booze
		when :foodBuff, :food                  then @on_food
		when :consumeBuff, :consume            then @on_consume
		when :criticalBuff, :critical          then @on_critical
		when :counterBuff, :counter            then @on_counter
		when :blockBuff, :block                then @on_block

		else raise ArgumentError, "#{what} is an unknown buff event"
		end
	end

	def inspect
		"#<Dredmor::Ability(#{name}): #{description.inspect}>"
	end
end

end; end
