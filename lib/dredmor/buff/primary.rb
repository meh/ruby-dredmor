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

class Primary < Buff
	def self.to_a
		@array ||= [Burliness, Sagacity, Nimbleness, Caddishness, Stubborness, Savvy]
	end

	def self.new (game, xml)
		return super unless self == Primary

		to_a[xml[:id].to_i].new(game, xml[:amount].to_f)
	end

	include Enumerable

	attr_reader :game, :id, :icon

	def initialize (game, amount)
		@game = game

		@id        = Primary.to_a.index(self.class)
		@amount    = amount
		@secondary = []
	end

	protected :initialize

	def each (&block)
		@secondary.each(&block)
	end

	def name
		self.class.name.downcase[/(?:::)?([^:]+)$/, 1].to_sym
	end

	alias to_sym name

	def to_f
		@amount
	end

	def to_i
		to_f.to_i
	end

	def inspect
		"#<Dredmor::Buff(#{name}): #{to_f}>"
	end
end

class Burliness < Primary
	def initialize (*)
		super

		@icon      = game.read_icon 'ui/icons/stat_burliness'
		@secondary = [Health.new(game, to_f * 1), MeleePower.new(game, to_f * 0.33), Block.new(game, to_f * 0.16)]
	end
end

class Sagacity < Primary
	def initialize (*)
		super

		@icon      = game.read_icon 'ui/icons/stat_sagacity'
		@secondary = [Mana.new(game, to_f * 2), MagicPower.new(game, to_f * 0.5)]
	end
end

class Nimbleness < Primary
	def initialize (*)
		super

		@icon      = game.read_icon 'ui/icons/stat_nimbleness'
		@secondary = [Dodge.new(game, to_f * 0.5), EnemyDodgeReduction.new(game, to_f * 0.33), Counter.new(game, to_f * 0.16), Sneakiness.new(game, to_f * 0.75)]
	end
end

class Caddishness < Primary
	def initialize (*)
		super

		@icon      = game.read_icon 'ui/icons/stat_caddishness'
		@secondary = [Health.new(game, to_f * 1), Critical.new(game, to_f * 0.5), Counter.new(game, to_f * 0.16)]
	end
end

class Stubborness < Primary
	def initialize (*)
		super

		@icon      = game.read_icon 'ui/icons/stat_stubborness'
		@secondary = [MagicResistance.new(game, to_f * 0.5), Block.new(game, to_f * 0.16)]
	end
end

class Savvy < Primary
	def initialize (*)
		super

		@icon      = game.read_icon 'ui/icons/stat_savvy'
		@secondary = [Haywire.new(game, to_f * 0.5), Sneakiness.new(game, to_f * 0.75)]
	end
end

end; end
