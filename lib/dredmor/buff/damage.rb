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
	include Comparable

	def initialize (game, xml = nil)
		@types = []

		if xml
			xml.attribute_nodes.each {|attr|
				begin
					@types << Type.new(game, attr.name, attr.value.to_f, xml["#{attr.name}F"].to_f)
				rescue ArgumentError; end
			}
		end
	end

	def each (&block)
		@types.each(&block)
	end

	def <=> (other)
		to_f <=> other.to_f
	end

	def to_f (*args)
		@types.map { |t| t.to_f(*args) }.reduce(0, :+)
	end

	def to_i (*args)
		to_f(*args).to_i
	end

	def inspect (*args)
		if @types.empty?
			"#<Dredmor::Damage: you just can't into it>"
		else
			"#<Dredmor::Damage(#{map(&:name).join(', ')}): #{to_f(*args)}>"
		end
	end

	class Type
		def self.new (game, *args)
			return super unless self == Type

			name, xml = args

			unless const = Damage.const_get(name.to_class_name) rescue false
				raise ArgumentError, "#{name} unknown damage type"
			end
			
			const.new(game, xml)
		end

		attr_reader :game, :icon, :scale

		def initialize (game, amount, scale = 0.0)
			@game = game

			@amount = amount.to_f
			@scale  = scale
			@armor  = false
		end

		protected :initialize

		def name
			self.class.name.downcase[/(?:::)?([^:]+)$/, 1].to_sym
		end

		def description
			game.texts!.tooltips.find { |t| t.panel == :damages && t.name.to_sym == name }
		end

		def armor?
			!!@armor
		end

		def to_f (primary = 0, secondary = 0)
			@amount + (@scale * primary) + (@scale * secondary)
		end

		def to_i (*args)
			to_f(*args).to_i
		end

		def inspect
			"#<Dredmor::Damage::#{name.to_class_name}: #{to_f}>"
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
