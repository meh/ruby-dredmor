#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor; module Unified

class Items
	include Enumerable

	attr_reader :game

	def initialize (game)
		@game = game
	end

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
end

end; end
