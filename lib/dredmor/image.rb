#--
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#++

class Dredmor

class Image
	def self.load (game, path)
		path = game.paths.map { |p| "#{p}/#{path}" }.find { |p| File.readable?(p) }

		File.open(path, 'r:binary') {|f|
			break new(f.read, path)
		}
	end

	attr_reader :path

	def initialize (data, path = nil)
		@data = data
		@path = path
	end

	def to_blob
		@data
	end

	def to_base64
		Base64.encode64(to_blob)
	end

	def inspect
		"#<#{self.class.name}: #{"#{path.inspect} " if path}#{@data.bytesize} bytes>"
	end
end

class Icon < Image
end

class Sprite
	include Enumerable

	def initialize (frames)
		@frames = frames.map { |d| Image.new(d) }
	end

	def each (&block)
		@frames.each(&block)
	end
end

end
