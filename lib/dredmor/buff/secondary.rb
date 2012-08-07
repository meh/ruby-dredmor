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

class Secondary < Buff
	def self.to_a
		@array ||= [
			Health, Mana, MeleePower, MagicPower, Critical, Haywire, Dodge, Block, Counter,
			EnemyDodgeReduction, ArmourAbsorption, MagicResistance, Sneakiness, HealthRegeneration, ManaRegeneration,
			WandBurnout, TrapAffinity, TrapSenseRadius, SightRadius, Smithing, Tinkering, Alchemy, MagicReflection, WandCrafting
		]
	end

	def self.new (game, xml)
		return super unless self == Secondary

		to_a[xml[:id].to_i].new(game, xml[:amount].to_f)
	end

	attr_reader :game, :id, :icon

	def initialize (game, amount)
		@game = game

		@id     = Secondary.to_a.index(self.class)
		@amount = amount
	end

	protected :initialize

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

class Health < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_life'
	end
end

class Mana < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_mana'
	end
end

class MeleePower < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_meleepower'
	end
end

class MagicPower < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_magicpower'
	end
end

class Critical < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_crit'
	end
end

class Haywire < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_haywire'
	end
end

class Dodge < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_dodge'
	end
end

class Block < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_block'
	end
end

class Counter < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_counter'
	end
end

class EnemyDodgeReduction < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_edr'
	end
end

class ArmourAbsorption < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_armourabsorption'
	end
end

class MagicResistance < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_magicresistance'
	end
end

class Sneakiness < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_sneakiness'
	end
end

class HealthRegeneration < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_liferegen'
	end
end

class ManaRegeneration < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_manaregen'
	end
end

class WandBurnout < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_wandburn'
	end
end

class TrapAffinity < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_traplevel'
	end
end

class TrapSenseRadius < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_trapsense'
	end
end

class SightRadius < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_sight'
	end
end

class Smithing < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_smithing'
	end
end

class Tinkering < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_tinkerer'
	end
end

class Alchemy < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_alchemy'
	end
end

class MagicReflection < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_reflection'
	end
end

class WandCrafting < Secondary
	def initialize (*)
		super

		@icon = game.read_icon 'ui/icons/stat_wandburn'
	end
end

end; end
