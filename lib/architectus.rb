# dependencies --------------------------------------------------------------------

require 'thor'

# ---------------------------------------------------------------------------------

# Require all components ----------------------------------------------------------

require_relative 'architectus/cli'

# ---------------------------------------------------------------------------------

module Architectus
  # Language modules namespace
  module Languages
  # Language classes are loaded through the require statements above
  end

  # Return the root path of the project
  def self.root
    File.expand_path('..', __dir__)
  end

  # Return the templates path
  def self.templates_path
    File.join(root, 'lib', 'architectus', 'templates')
  end
  
end
