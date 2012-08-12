#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor

module WithBuffs
	attr_reader :buffs
	attr_reader :on_hit, :on_kill, :on_being_hit, :on_crossbow_shot, :on_thrown,
	            :on_cast, :on_dodge, :on_booze, :on_food, :on_consume, :on_critical, :on_counter,
	            :on_block

	def on (what)
		case what.to_sym
		when :targetHitEffectBuff, :hit        then @on_hit
		when :targetKillBuff, :kill            then @on_kill
		when :playerHitEffectBuff, :being_hit  then @on_being_hit
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

	def from_xml (xml)
		@buffs ||= []

		@on_hit           ||= []
		@on_kill          ||= []
		@on_being_hit     ||= []
		@on_crossbow_shot ||= []
		@on_thrown        ||= []
		@on_cast          ||= []
		@on_dodge         ||= []
		@on_booze         ||= []
		@on_food          ||= []
		@on_consume       ||= []
		@on_critical      ||= []
		@on_counter       ||= []
		@on_block         ||= []

		xml.elements.each {|element|
			case element.name
			when 'primarybuff', 'secondarybuff', 'resistbuff', 'damagebuff'
				@buffs << Buff.new(game, element)

			when 'targetHitEffectBuff', 'targetKillBuff', 'playerHitEffectBuff', 'crossbowShotBuff',
			     'thrownBuff', 'triggerOnCast', 'dodgeBuff', 'boozeBuff', 'foodBuff', 'consumeBuff',
			     'criticalBuff', 'counterBuff', 'blockBuff'
				on(element.name) << Spells::Probability.new(game.spells[element[:name]], element[:percentage].to_i, element[:after].to_i)
			end
		}
	end

	private :from_xml
end

end

class String
	def to_class_name
		capitalize.gsub(/_(.)/) { |c| $1.upcase }
	end
end

class Symbol
	def to_class_name
		to_s.to_class_name.to_sym
	end
end
