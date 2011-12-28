### 
# Compass
###

# Susy grids in Compass
# First: gem install compass-susy-plugin
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Haml
###

# CodeRay syntax highlighting in Haml
# First: gem install haml-coderay
# require 'haml-coderay'

# CoffeeScript filters in Haml
# First: gem install coffee-filter
# require 'coffee-filter'

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

###
# Page command
###

# Per-page layout changes:
# 
# With no layout
# page "/path/to/file.html", :layout => false
# 
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
# 
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

set :md, :layout_engine => :erb

page "/index.html", :layout => "views/layouts/html5"
#page "/steps/*", :layout => "views/layouts/html5"

(0..16).each do |step_num|
  page "/steps/#{step_num}.html", :layout => "views/layouts/html5" do
    @step_num = step_num
  end
end

# ["tom", "dick", "harry"].each do |name|
#   page "/about/#{name}.html", :proxy => "/about/template.html" do
#     @person_name = name
#   end
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do
  def step(num)
    if @step_num and @step_num >= num
      true 
    else
      false
    end
  end
  
  def title_text_from_step(step_num)
    file = File.read File.join(steps_root, "#{step_num}.html.md")
    first_line = file.split("\n").first
    title_parts = first_line.split('.')
    title_parts.shift
    title_parts.join('.').gsub('`', '')
  end
  
  def title_text
    title_text_from_step(@step_num)
  end
  
  def steps_root
    File.join(File.expand_path(File.dirname(__FILE__)), 'source', 'steps')
  end
  
  def tutorial_steps    
    (0..16).map do |step_num|
      title_text_from_step(step_num)
    end    
  end
  
  def image_tag_options
    default_values = {:id => 'main_image', :alt => 'Students jumping in front of Memorial Bell Tower'}
    if step(3)
     {'itemprop' => 'image'}.merge(default_values)
    else
      default_values
    end
  end
  
end

# Change the CSS directory
# set :css_dir, "alternative_css_directory"

# Change the JS directory
# set :js_dir, "alternative_js_directory"

# Change the images directory
# set :images_dir, "alternative_image_directory"

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css
  
  # Minify Javascript on build
  # activate :minify_javascript
  
  # Enable cache buster
  # activate :cache_buster
  
  # Use relative URLs
  # activate :relative_assets
  
  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher
  
  # Or use a different image path
  # set :http_path, "/Content/images/"
end