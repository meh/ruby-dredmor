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

class Scrolls < Unified
	include Enumerable

	def each (&block)
		return to_enum unless block

		game.each {|part|
			part.scrolls.each(&block)
		}

		self
	end

	def [] (name)
		game.each {|part|
			if power = part.scrolls[name]
				return power
			end
		}

		nil
	end
end

end; end
