module Architectus
  # Main CLI class for the language scaffold tool
  class CLI < Thor
    include Thor::Actions

    # Method to check if 'figlet' and 'lolcat' is installed and display the banner if so
    def self.show_banner
      # Check if 'figlet' and 'loclat' is available on the system
      if system("which figlet > /dev/null 2>&1") && system("which lolcat > /dev/null 2>&1")
        system("figlet Architectus | lolcat")
      else
        puts "Figlet or lolcat is not installed, skipping banner."
      end
    end

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
      self.class.show_banner
      pastel = Pastel.new
      puts pastel.cyan.bold("Architectus v#{Architectus::VERSION}")
    end

    desc 'new PROJECT_NAME', 'Create a new project with the specified structure'
    method_option :language, aliases: '-l', type: :string, default: 'ruby', desc: 'Programming language to scaffold'
    def new(project_name)
      self.class.show_banner

      pastel = Pastel.new
      spinner = TTY::Spinner.new("[:spinner] Creating #{pastel.cyan(project_name)} project... :title", format: :dots)

      print_welcome_box(project_name, options[:language])

      # create project
      begin
        spinner.auto_spin

        spinner.update(title: "Getting the appropriate language scaffolder")
        scaffolder = get_scaffolder(options[:language])
        

        # Print success message
        puts ""
        puts pastel.green.bold("✅ Project created successfully!")
        puts pastel.cyan("Your #{options[:language].capitalize} project is ready in ./#{project_name}")
        puts ""
        puts "Next steps:"
        puts pastel.yellow("  cd #{project_name}")
        scaffolder.next_steps.each do |step|
          puts pastel.yellow("  #{step}")
        end
      rescue StandardError => e
        puts pastel.red("Failed to create project: #{e.message}")
        exit(1)
      end
      
      
    end

    desc 'list', 'List all supported programming languages'
    def list
      self.class.show_banner

      pastel = Pastel.new
      puts pastel.cyan.bold("Supported Languages:")
      puts pastel.green("  • Ruby")
      puts ""
      puts pastel.yellow("More languages coming soon!")
    end

    private

    def get_scaffolder(language)
      case language.downcase
      when 'ruby'
        Architectus::Languages::Ruby.new
      else
        raise "Unsupported language: #{language}"
      end
    end

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
