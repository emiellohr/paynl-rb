Gem::Specification.new do |s|
  s.name        = 'paynl-rb'
  s.version     = '0.0.0'
  s.platform    = Gem::Platform::RUBY
  s.date        = '2015-04-21'
  s.summary     = %q{Rails gem for payments through Pay.nl.}
  s.description = %q{This gem implements the REST API of the Pay.nl payment provider.}
  s.authors     = ["Emiel Lohr"]
  s.email       = 'e.lohr@avayo.nl'
  s.files       = ["lib/paynl-rb.rb"]
  s.homepage    = 'http://github.com/emiellohr/paynl-rb'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'httpi'
  s.add_dependency 'httpclient'
  s.add_dependency 'hashie'
  s.add_dependency 'crack'
  s.add_dependency 'activesupport'
end