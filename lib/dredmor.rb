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
require 'dredmor/helpers'

class Dredmor
	autoload :Unified, 'dredmor/unified'

	autoload :Image, 'dredmor/image'
	autoload :Icon, 'dredmor/image'
	autoload :Sprite, 'dredmor/image'

	autoload :Buff, 'dredmor/buff'
	autoload :Damage, 'dredmor/buff'
	autoload :Resistance, 'dredmor/buff'

	autoload :Items, 'dredmor/items'
	autoload :Powers, 'dredmor/powers'
	autoload :Recipes, 'dredmor/recipes'
	autoload :Monsters, 'dredmor/monsters'

	autoload :Skills, 'dredmor/skills'
	autoload :Skill, 'dredmor/skills'
	autoload :Ability, 'dredmor/skills'

	autoload :Spells, 'dredmor/spells'

	class Core
		attr_reader :game

		def initialize (game)
			@game = game
		end

		def read_xml (name)
			Nokogiri::XML.parse(File.read("#{path}/game/#{name}.xml"))
		rescue
			nil
		end

		def read_icon (name)
			path = "#{path}/#{name}.png"

			file = File.new(name, 'r:binary')
			icon = Icon.new(file.read, "#{path}/#{name}.png")
			file.close

			icon
		rescue
			nil
		end

		def read_animation (name)
			raise NotImplementedError
		end

		def read_sprite (name)
			raise NotImplementedError
		end

		%w[items powers recipes monsters skills spells].each {|name|
			define_method name do
				return instance_variable_get "@#{name}" if instance_variable_defined? "@#{name}"

				instance_variable_set "@#{name}", Dredmor.const_get(name.capitalize).new(self)
			end
		}
	end

	class Expansion < Core
		ByNumber = {
			1 => 'Real of the Diggle Gods',
			2 => 'You Have To Name The Expansion Pack',
			3 => 'Conquest of the Wizardlands'
		}

		attr_reader :game, :name, :path

		def initialize (game, name, path)
			@game = game
			@name = name
			@path = path
		end

		def read_icon (name)
			["#{path}/#{name}.png", "#{game.path}/#{name}.png"].each {|path|
				next unless File.readable?(path)

				file = File.new(path, 'r:binary')
				icon = Icon.new(file.read, path)
				file.close

				return file
			}

			nil
		end

		def inspect
			"#<Dredmor::Expansion: #{name}>"
		end
	end

	class Mod < Core
		attr_reader :game, :name, :version, :description, :author, :requires

		def initialize (game, path)
			@game = game
			@path = path

			if @path.end_with? '.zip'
				@zip = Zip::ZipFile.new(path)
			end

			read_xml('mod').tap {|xml|
				@name        = xml.at('name')[:text]
				@version     = xml.at('revision')[:text]
				@description = xml.at('description')[:text]

				xml.xpath('.//require').each {|element|
					@requires.push(Expansion::ByNumber[element[:expansion].to_i])
				}
			}
		end

		def read_xml (name)
			Nokogiri::XML.parse(read("mod/#{name}.xml"))
		rescue
			nil
		end

		def read_icon (name)
			Icon.new(read("#{name}.png", :binary), "#{name}.png")
		rescue
			nil
		end

		def zip?
			!!@zip
		end

		def read (name, encoding = false)
			if @zip
				@zip.entries {|z|
					return z.get_input_stream.read if z.to_s == name
				}
			else
				File.open(name, "r#{":#{encoding}" if encoding}") {|f|
					return f.read
				}
			end

			nil
		end

		private :read
	end

	attr_reader :path, :core, :expansions, :mods

	def initialize (path, mod_path = nil)
		@path = File.expand_path(path)
		@core = Core.new(self)

		@expansions = Dir["#@path/expansion*"].map {|path|
			Expansion.new(self, Expansion::ByNumber[(File.basename(path)[/\d+$/] || 1).to_i], path)
		}.compact.freeze

		@mods = mod_path ? Dir["#{mod_path}/*"].map {|path|
			Mod.new(self, path)
		}.compact.freeze : []
	end

	def inspect
		"#<Dredmor#{"(#{expansions.map(&:name).join(', ')})" unless expansions.empty?}: #{path.inspect}>"
	end
end
