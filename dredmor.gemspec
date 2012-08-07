Kernel.load 'lib/dredmor/version.rb'

Gem::Specification.new {|s|
	s.name         = 'dredmor'
	s.version      = Dredmor.version
	s.author       = 'meh.'
	s.email        = 'meh@paranoici.org'
	s.homepage     = 'http://github.com/meh/ruby-dredmor'
	s.platform     = Gem::Platform::RUBY
	s.summary      = "Library to deal with Dungeons of Dredmor's game data."

	s.files         = `git ls-files`.split("\n")
	s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	s.require_paths = ['lib']

	s.add_runtime_dependency 'nokogiri'
	s.add_runtime_dependency 'zip'
}
