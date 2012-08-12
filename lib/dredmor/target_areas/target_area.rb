#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'matrix'

class Dredmor; class TargetAreas

class TargetArea
	class Element
		def self.new (*args)
			return super() unless self == Element

			case args.first
			when '.' then Unaffected
			when '@' then Affected
			when '#' then Player

			else raise ArgumentError, "#{args.first} is an unknown target area element"
			end.new
		end

		def to_sym
			self.class.name.downcase[/(?:::)?([^:]+)$/, 1].to_sym
		end

		alias to_str to_s

		class Unaffected < Element
			def to_s
				'.'
			end
		end

		class Affected < Element
			def to_s
				'@'
			end
		end

		class Player < Element
			def to_s
				'#'
			end
		end
	end

	attr_reader :game, :id

	def initialize (game, xml)
		@game = game

		@id     = xml[:name].to_i
		@matrix = Matrix.rows(xml.css('row').map {|row|
			chars = row[:text].chars.to_a
			
			if chars.length < (width = xml[:width].to_i)
				chars.push(*('.' * (width - chars.length)))
			end

			chars.map { |c| Element.new(c) }
		})

		@affects_player = xml[:affectsPlayer] == '1'
	end

	def respond_to_missing? (*args)
		@matrix.respond_to?(*args)
	end

	def method_missing (id, *args, &block)
		if @matrix.respond_to? id
			return @matrix.__send__ id, *args, &block
		end

		super
	end

	def affects_player?
		@affects_player
	end

	def inspect
		"#<Dredmor::TargetArea(#{id}): \n  #{rows.map(&:join).join("\n  ")}\n>"
	end
end

end; end
