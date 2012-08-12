#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; class Unified

class Spells < Unified
	include Enumerable

	def each (&block)
		return to_enum unless block

		game.each {|part|
			part.spells.each(&block)
		}

		self
	end

	def [] (name)
		game.each {|part|
			if spell = part.spells[name]
				return spell
			end
		}

		nil
	end
end

end; end
