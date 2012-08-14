#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Spells

class Buff
	include Enumerable
	include WithBuffs

	attr_reader :game, :spell, :duration, :limit, :icon, :small_icon

	def initialize (spell, xml)
		@game  = spell.game
		@spell = spell

		if time = xml[:time]
			@duration = time.to_i
		end

		if xml[:allowstacking] == '1'
			@limit = xml[:stacksize].to_i
		end

		@self = self == '1'

		if xml[:icon]
			@icon = game.read_icon(xml[:icon])
		end

		if xml[:smallicon]
			@small_icon = game.read_icon(xml[:smallicon])
		end

		from_xml(xml)
	end

	def stackable?
		!!@limit
	end

	def self?
		@self
	end

	def each (&block)
		return to_enum unless block

		buffs.each(&block)

		self
	end
end

end; end
