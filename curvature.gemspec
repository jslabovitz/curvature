Gem::Specification.new do |s|
  s.name          = 'curvature'
  s.version       = '0.1'
  s.summary       = 'Acquires samples, generates curves to fit those samples, and charts the results.'
  s.author        = 'John Labovitz'
  s.email         = 'johnl@johnlabovitz.com'
  s.description   = %q{
Curvature helps in acquiring samples, generating curves to fit those samples, and charting the results.
}
  s.homepage      = 'http://github.com/jslabovitz/curvature'
  s.license       = 'MIT'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path  = 'lib'

  s.add_dependency 'spliner'
  s.add_dependency 'builder'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
end