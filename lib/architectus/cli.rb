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

    # commands ------------------------------------------------------------------------------------------------

    desc 'version', 'Display Architectus version'
    def version
      pastel = Pastel.new
      puts pastel.cyan.bold("Architectus v#{Architectus::VERSION}")
    end

    desc 'new PROJECT_NAME', 'Create a new project with the specified structure'
    method_option :language, aliases: '-l', type: :string, default: 'ruby', desc: 'Programming language to scaffold'
    def new(project_name)

      print_welcome_box(project_name, options[:language])
      
    end

    desc 'list', 'List all supported programming languages'
    def list
      pastel = Pastel.new
      puts pastel.cyan.bold("Supported Languages:")
      puts pastel.green("  • Ruby")
      puts ""
      puts pastel.yellow("More languages coming soon!")
    end

    private

    def print_welcome_box(project_name, language)
      pastel = Pastel.new
      
      box = TTY::Box.frame(
        width: 60,
        height: 7,
        border: :thick,
        align: :center,
        padding: [1, 2],
        title: { top_left: ' Architectus ', bottom_right: " v#{Architectus::VERSION} " },
        enable_color: true,
        style: {
          border: {
            fg: :bright_cyan,
          }
        }
      ) do
        "Creating #{pastel.bright_white.bold(project_name)}\n" +
        "#{pastel.bright_white("with")} #{pastel.bright_red.bold(language.capitalize)} #{pastel.bright_white("structure")}"
      end
      
      puts box
    end
  end
end
