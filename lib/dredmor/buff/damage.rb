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

class Damage < Buff
	include Enumerable

	def initialize (game, xml)
		@types = xml.attribute_nodes.map {|attr|
			Type.new(game, attr.name, attr.value.to_f)
		}
	end

	def each (&block)
		@types.each(&block)
	end

	def to_f
		@types.map(&:to_f).inject(:+)
	end

	def to_i
		to_f.to_i
	end

	def inspect
		"#<Dredmor::Damage(#{map(&:name).join(', ')}): #{to_f}>"
	end

	class Type
		def self.new (game, *args)
			return super unless self == Type

			Damage.const_get(args.first.to_sym.capitalize).new(game, args.last)
		end

		attr_reader :game

		def initialize (game, amount)
			@game = game

			@amount = amount.to_f
			@armor  = false
		end

		protected :initialize

		def name
			self.class.name.downcase[/(?:::)?([^:]+)$/, 1].to_sym
		end

		def armor?
			@armor
		end

		def to_f
			@amount
		end

		def to_i
			to_f.to_i
		end
	end

	class Crushing < Type
		def initialize (*)
			super

			@armor = true
			@icon  = game.read_icon 'ui/icons/dmg_crushing'
		end
	end

	class Slashing < Type
		def initialize (*)
			super

			@armor = true
			@icon  = game.read_icon 'ui/icons/dmg_slashing'
		end
	end

	class Piercing < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_piercing'
		end
	end

	class Blasting < Type
		def initialize (*)
			super

			@armor = true
			@icon  = game.read_icon 'ui/icons/dmg_blast'
		end
	end

	class Hyperborean < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_hyperborean'
		end
	end

	class Conflagratory < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_conflagratory'
		end
	end

	class Voltaic < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_voltaic'
		end
	end

	class Toxic < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_toxic'
		end
	end

	class Righteous < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_righteous'
		end
	end

	class Necromantic < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_necromatic'
		end
	end
	
	class Acidic < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_acidic'
		end
	end

	class Putrefying < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_putrefying'
		end
	end

	class Transmutative < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_transmutative'
		end
	end

	class Aethereal < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_aethereal'
		end
	end

	class Asphyxiative < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_asphyxiative'
		end
	end

	class Existential < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_existential'
		end
	end
end

end; end
