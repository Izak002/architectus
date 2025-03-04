module Architectus
  module Languages
    # Ruby language scaffolder
    class Ruby
      include Thor::Actions

      def initialize
      end 

      def create(project_path)
        # Create the base directory
        FileUtils.mkdir_p(project_path)
      end

      def next_steps
        [
          "bundle install",
          "git init",
          "git add .",
          "git commit -m 'Initial commit'"
        ]
      end

    end
  end
end