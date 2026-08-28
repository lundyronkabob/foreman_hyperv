Gem::Specification.new do |s|
  s.name        = "foreman_hyperv"
  s.version     = "0.0.1"
  s.summary     = "Hyper-V Compute Resource Plugin for Foreman"
  s.description = "Adds Hyper-V support to Foreman using WinRM transport."
  s.authors     = ["Naveed Hussain"]
  s.email       = ["naveedhussain1187@outlook.com"]
  s.homepage    = "http://giterdun:8080/hb19867/foreman_hyperv"
  s.license     = "MIT"

  s.files = Dir[
    "app/**/*",
    "config/**/*"
    "lib/foreman_hyperv.rb",
    "lib/foreman_hyperv/**/*",
    "README.md"
  ]


  s.add_dependency "winrm", "~> 2.3"
  s.add_dependency "winrm-fs", "~> 1.3"
end
