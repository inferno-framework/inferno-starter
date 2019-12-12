require "inferno_starter/version"

# Require the inferno library
require 'inferno'

# require all sequences defined in the app
Dir.glob(File.join(__dir__, 'inferno_starter', 'modules', '**', '*_sequence.rb')).each { |file| require file }

module InfernoStarter
  def self.start_app
    # Load the modules
    Dir.glob(File.join(__dir__, 'inferno_starter', 'modules', '*_module.yml')).each do |file|
      puts file
      this_module = YAML.load_file(file).deep_symbolize_keys
      Inferno::Module.new(this_module)
    end

    example_module = Inferno::Module.get('example_module')
    puts 'mod'
    puts example_module
    # Add to module list as the only module (can << if you want to keep Inferno defaults too)
    Inferno::App::Endpoint.inferno_modules = [ example_module ]
    # Inferno::App::Endpoint.inferno_modules << example_module
    Inferno::App.new
  end
end
