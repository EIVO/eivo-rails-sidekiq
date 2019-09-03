$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'eivo-rails-sidekiq'
  spec.version       = '0.0.2'
  spec.authors       = ['Jonathan VUKOVICH-TRIBOUHARET']
  spec.email         = ['jonathan@eivo.co']

  spec.summary       = 'EIVO Rails Sidekiq'
  spec.description   = 'EIVO Rails Sidekiq'
  spec.homepage      = 'https://www.eivo.co'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0")
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'sidekiq', '< 6'
  spec.add_dependency 'redis-namespace'
  spec.add_dependency 'hiredis'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
