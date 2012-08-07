#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'dredmor/items/item'
require 'dredmor/items/food'
require 'dredmor/items/potion'
require 'dredmor/items/mushroom'
require 'dredmor/items/gem'
require 'dredmor/items/trap'
require 'dredmor/items/weapon'
require 'dredmor/items/wand'
require 'dredmor/items/armour'
require 'dredmor/items/toolkit'
require 'dredmor/items/lockpick'

class Dredmor

class Items
	include Enumerable

	attr_reader :game

	def initialize (game)
		@game = game

		@foods     = []
		@potions   = []
		@mushrooms = []
		@gems      = []
		@traps     = []
		@weapons   = []
		@wands     = []
		@armours   = []
		@toolkits  = []
		@items     = []

		game.read_xml('itemDB').xpath('//item').each {|xml|
			if xml.at('food')
				@foods << Food.new(game, xml)
			elsif xml.at('potion')
				@potions << Potion.new(game, xml)
			elsif xml.at('mushroom')
				@mushrooms << Mushroom.new(game, xml)
			elsif xml.at('gem')
				@gems << Gem.new(game, xml)
			elsif xml.at('trap')
				@traps << Trap.new(game, xml)
			elsif xml.at('weapon')
				@weapons << Weapon.new(game, xml)
			elsif xml.at('wand')
				@wands << Wand.new(game, xml)
			elsif xml.at('armour')
				@armours << Armour.new(game, xml)
			elsif xml.at('toolkit')
				@toolkits << Toolkit.new(game, xml)
			else
				@items << Item.new(game, xml)
			end
		}

		@items << Lockpick.new(game)
	end

	def each (what = nil, &block)
		return enum_for :each, what unless block

		if what
			instance_variable_get("@#{what}s").each(&block)
		else
			each(:item, &block)
			each(:food, &block)
			each(:mushroom, &block)
			each(:gem, &block)
			each(:trap, &block)
			each(:weapon, &block)
			each(:wand, &block)
			each(:armour, &block)
			each(:toolkit, &block)
		end

		self
	end

	%w[food potion mushroom gem trap weapon wand armour toolkit].each {|name|
		define_method "#{name}s" do |&block|
			each(name, &block)
		end
	}

	def [] (name)
		find { |i| name === i.name }
	end
end

Item     = Items::Item
Food     = Items::Food
Potion   = Items::Potion
Mushroom = Items::Mushroom
Gem      = Items::Gem
Trap     = Items::Trap
Weapon   = Items::Weapon
Wand     = Items::Wand
Armour   = Items::Armour

end
