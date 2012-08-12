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

class Items < Unified
	include Enumerable

	def each (what = nil, &block)
		return enum_for :each, what unless block

		game.each {|part|
			part.items.each(what, &block)
		}

		self
	end

	%w[food potion mushroom gem trap weapon wand armour toolkit reagent].each {|name|
		define_method "#{name}s" do |&block|
			each(name, &block)
		end
	}

	def misc (&block)
		each(:misc, &block)
	end

	def [] (name)
		game.each {|part|
			if item = part.items[name]
				return item
			end
		}

		nil
	end
end

end; end
