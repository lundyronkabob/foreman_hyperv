Gem::Specification.new do |s|
  s.name        = "foreman_hyperv"
  s.version     = "0.0.1"
  s.summary     = "Hyper-V Compute Resource Plugin for Foreman"
  s.description = "Adds Hyper-V support to Foreman using WinRM transport."
  s.authors     = ["Naveed Hussain"]
  s.email       = ["naveedhussain1187@outlook.com"]
  s.homepage    = "http://giterdun:8080/hb19867/foreman_hyperv"
  s.license     = "MIT"

  # Include all plugin files
  s.files = Dir[
    "app/**/*",
    "lib/**/*",
    "README.md",
    "Gemfile.plugin"
  ]

  # Foreman plugin dependency
  s.add_dependency "foreman", ">= 3.0"

  # WinRM dependencies
  s.add_dependency "winrm", "~> 2.3"
  s.add_dependency "winrm-fs", "~> 1.3"

  # Rails engine support
  s.add_dependency "railties"
end
