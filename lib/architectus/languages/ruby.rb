module Architectus
  module Languages
    # Ruby language scaffolder
    class Ruby
      include Thor::Actions

      def initialize
        @pastel = Pastel.new
      end 

      def create(project_path)
        # Set the project_name instance variable
        @project_name = File.basename(project_path)

        # Create the base project structure
        directories = [
          "#{project_path}/lib",
          "#{project_path}/spec",
          "#{project_path}/bin",
          "#{project_path}/config",
          "#{project_path}/docs"
        ]
        
        directories.each { |dir| FileUtils.mkdir_p(dir) }

        # Generate template-based files
        puts ""
        generate_templates(project_path)
      end

      def next_steps
        [
          "bundle install",
          "git init",
          "git add .",
          "git commit -m 'Initial commit'"
        ]
      end

      private

      def generate_templates(project_path)
        # Use instance variable @project_name in all template calls
        [
          ["Gemfile.erb", "#{project_path}/Gemfile"],
          ["README.md.erb", "#{project_path}/README.md"],
          ["gitignore.erb", "#{project_path}/.gitignore"],
          ["main.rb.erb", "#{project_path}/lib/main.rb"],
          ["spec_helper.rb.erb", "#{project_path}/spec/spec_helper.rb"]
        ].each do |template_name, destination|
          copy_template(template_name, destination)
        end
      end

      def copy_template(template_name, destination)
        template_path = File.join(Architectus.templates_path + "/ruby", template_name)
        if File.exist?(template_path)
          content = ERB.new(File.read(template_path)).result(binding)
          File.write(destination, content)
        else
          puts @pastel.bright_magenta("Warning: ") + "Template #{template_name} not found"
        end
      end
    end
  end
end
