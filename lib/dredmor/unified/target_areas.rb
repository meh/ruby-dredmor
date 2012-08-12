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

class TargetAreas < Unified
	include Enumerable

	def each (&block)
		return to_enum unless block

		game.each {|part|
			part.target_areas.each(&block)
		}

		self
	end

	def [] (id)
		game.each {|part|
			if target_area = part.target_areas[id]
				return target_area
			end
		}

		nil
	end
end

end; end
