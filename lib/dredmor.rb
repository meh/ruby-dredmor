#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

require 'nokogiri'
require 'base64'

require 'dredmor/version'

class Dredmor
	autoload :Image, 'dredmor/image'
	autoload :Icon, 'dredmor/image'
	autoload :Sprite, 'dredmor/image'

	autoload :Buff, 'dredmor/buff'

	autoload :Items, 'dredmor/items'
	autoload :Craftings, 'dredmor/craftings'
	autoload :Encrustings, 'dredmor/encrustings'
	autoload :Monsters, 'dredmor/monsters'

	autoload :Skills, 'dredmor/skills'
	autoload :Skill, 'dredmor/skills'
	autoload :Ability, 'dredmor/skills'

	autoload :Spells, 'dredmor/spells'

	class Expansion < Dredmor
		attr_reader :game, :name, :path

		def initialize (game, name, path)
			@game = game
			@name = name
			@path = path
		end

		def paths
			game.paths + [path]
		end

		def inspect
			"#<Dredmor::Expansion: #{name}>"
		end
	end

	attr_reader :path, :expansions

	def initialize (path)
		@path       = File.expand_path(path)
		@expansions = Dir["#@path/expansion*"].map {|path|
			name = case File.basename(path)
				when 'expansion'  then 'Realm of the Diggle Gods'
				when 'expansion2' then 'You Have To Name The Expansion Pack'
				when 'expansion3' then 'Conquest of the Wizardlands'
			end or next

			Expansion.new(self, name, path)
		}.compact
	end

	def paths
		[path]
	end

	%w[items craftings encrustings monsters skills spells].each {|name|
		define_method name do
			return instance_variable_get "@#{name}" if instance_variable_defined? "@#{name}"

			instance_variable_set "@#{name}", Dredmor.const_get(name.capitalize).new(self)
		end
	}

	def inspect
		"#<Dredmor#{"(#{expansions.map(&:name).join(', ')})" unless expansions.empty?}: #{path.inspect}>"
	end
end
