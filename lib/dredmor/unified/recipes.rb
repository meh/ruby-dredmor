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

class Recipes < Unified
	include Enumerable

	def each (name = nil, &block)
		return enum_for :each, name unless block

		game.each {|part|
			part.recipes.each(name, &block)
		}

		self
	end

	def crafting (tool = nil, &block)
		return enum_for :crafting, tool unless block

		game.each {|part|
			part.recipes.crafting(tool, &block)
		}

		self
	end

	def encrusting (tool = nil, &block)
		return enum_for :encrusting, tool unless block

		game.each {|part|
			part.recipes.encrusting(tool, &block)
		}

		self
	end

	def [] (name)
		game.each {|part|
			if recipe = part.recipes[name]
				return recipe
			end
		}

		nil
	end
end

end; end
