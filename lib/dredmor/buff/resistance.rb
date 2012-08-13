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

class Resistance < Buff
	include Enumerable
	include Comparable

	def initialize (game, xml = nil)
		@types = []

		if xml
			xml.attribute_nodes.each {|attr|
				begin
					@types << Type.new(game, attr.name, attr.value.to_f)
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

	def to_f
		@types.map(&:to_f).reduce(0, :+)
	end

	def to_i
		to_f.to_i
	end

	def inspect
		if @types.empty?
			"#<Dredmor::Resistance: it is futile>"
		else
			"#<Dredmor::Resistance(#{map(&:name).join(', ')}): #{to_f}>"
		end
	end

	class Type
		def self.new (game, *args)
			return super unless self == Type

			name, xml = args

			unless const = Resistance.const_get(name.to_sym.capitalize) rescue false
				raise ArgumentError, "#{name} unknown resistance type"
			end
			
			const.new(game, xml)
		end

		attr_reader :game, :icon

		def initialize (game, amount)
			@game = game

			@amount = amount.to_f
			@armor  = false
		end

		protected :initialize

		def name
			self.class.name.downcase[/(?:::)?([^:]+)$/, 1].to_sym
		end

		def description
			game.texts!.tooltips.find { |t| t.panel == :resistances && t.name.to_sym == name }
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

		def inspect
			"#<Dredmor::Resistance::#{name.capitalize}: #{to_f}>"
		end
	end

	class Crushing < Type
		def initialize (*)
			super

			@armor = true
			@icon  = game.read_icon 'ui/icons/dmg_crushing_resist'
		end
	end

	class Slashing < Type
		def initialize (*)
			super

			@armor = true
			@icon  = game.read_icon 'ui/icons/dmg_slashing_resist'
		end
	end

	class Piercing < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_piercing_resist'
		end
	end

	class Blasting < Type
		def initialize (*)
			super

			@armor = true
			@icon  = game.read_icon 'ui/icons/dmg_blast_resist'
		end
	end

	class Hyperborean < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_hyperborean_resist'
		end
	end

	class Conflagratory < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_conflagratory_resist'
		end
	end

	class Voltaic < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_voltaic_resist'
		end
	end

	class Toxic < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_toxic_resist'
		end
	end

	class Righteous < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_righteous_resist'
		end
	end

	class Necromantic < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_necromatic_resist'
		end
	end
	
	class Acidic < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_acidic_resist'
		end
	end

	class Putrefying < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_putrefying_resist'
		end
	end

	class Transmutative < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_transmutative_resist'
		end
	end

	class Aethereal < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_aethereal_resist'
		end
	end

	class Asphyxiative < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_asphyxiative_resist'
		end
	end

	class Existential < Type
		def initialize (*)
			super

			@icon = game.read_icon 'ui/icons/dmg_existential_resist'
		end
	end
end

end; end
