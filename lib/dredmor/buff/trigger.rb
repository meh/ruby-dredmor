#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Buff

class Trigger
	attr_reader :game, :after, :affects

	def initialize (game, spell_name, percentage, after = 0, affects = nil)
		@game       = game
		@spell_name = spell_name
		@percentage = percentage.to_i
		@after      = after
		@affects    = affects ? affects.downcase.to_sym : :everyone
	end

	def spell
		@spell ||= game.spells![@spell_name]
	end

	def to_i
		@percentage
	end

	def to_f
		to_i / 100.0
	end

	def inspect
		"#<Dredmor::Buff::Trigger(#{to_i}%#{", after #{after}" if after}): #{spell.inspect}>"
	end
end

end; end
