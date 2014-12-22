require './app'

# Configuration to use when running within Sinatra
project_path          = Sinatra::Application.root

# Set this to the root of your project when deployed:
http_path       = "/"
css_dir         = ".tmp/css"
sass_dir        = "app/assets/css"
images_dir      = "app/assets/img"
javascripts_dir = "app/assets/js"

# Syntax preference
preferred_syntax      = :scss

# Determine whether Compass generates relative or absolute paths
relative_assets       = false

# Determines whether line comments should be added to compiled css for easier debugging
line_comments         = false

# CSS output style - :nested, :expanded, :compact, or :compressed
output_style          = :expanded
