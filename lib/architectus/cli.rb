module Architectus
  # Main CLI class for the language scaffold tool
  class CLI < Thor
    include Thor::Actions

    # creates aliases/shortcuts for commands
    map %w[--version -v] => :version
    map %w[--help -h] => :help

    # tells Thor to exit the program with a non-zero exit code whenever a command fails or raises an exception.
    def self.exit_on_failure?
      true
    end

    # commands
    desc 'version', 'Display Architectus version'
    def version
      pastel = Pastel.new
      puts pastel.cyan.bold("Architectus v#{Architectus::VERSION}")
    end
  end
end
