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

class Probability
	attr_reader :spell, :after

	def initialize (spell, percentage, after = 0)
		@spell      = spell
		@percentage = percentage.to_i
		@after      = after
	end

	def to_i
		@percentage
	end

	def to_f
		to_i / 100.0
	end

	def inspect
		"#<Dredmor::Probability(#{to_i}%#{", after #{after}" if after}): #{spell.inspect}>"
	end
end

end; end
