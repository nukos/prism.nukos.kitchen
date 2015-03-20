require 'aws-sdk-v1'

########################
#
# Site setting
#
########################
Time.zone = "Tokyo"
set :encoding, 'utf-8'

set :site_url,              'http://example.com'
set :site_name,             'PRISM α'
set :site_title,            'PRISM α - SCSS Color Code Management'
set :site_subtitle,         'SCSS Color Code Management'
set :site_description,      'Example Site Description.'
set :site_keywords,         'site keywords, hogehoge, fugafuga'
set :site_author,           'Ryuichi Nonaka'


########################
#
# Path setting
#
########################
set :http_prefix,      '/'
set :relative_links,   false
set :strip_index_file, true
set :trailing_slash,   true


########################
#
# Directory setting
#
########################
set :source,       'source'
set :build_dir,    'build'
set :data_dir,     'data'

set :layouts_dir,  'layouts'
set :partials_dir, 'partials'
set :helpers_dir,  'helpers'

# assets helper
set :css_dir,      'assets/css'
set :js_dir,       'assets/js'
set :fonts_dir,    'assets/fonts'
set :images_dir,   'assets/images'

# etc
set :index_file,   'index.html'
set :layout,       'layout'


########################
#
# Markdown setting
#
########################
# set :markdown_engine, :kramdown
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true, :with_toc_data => true, :tables => true, :autolink => true, :gh_blockcode => true

########################
#
# Code highlight
#
########################
# activate :rouge_syntax
activate :syntax, :line_numbers => true


########################
#
# Sass/SCSS setting
#
########################
configure :development do
  set :sass, {
    :style => :nested
  }
  set :sass_assets_paths, []
end

configure :build do
  set :sass, {
    :style => :compressed
  }
  set :sass_assets_paths, []
end


########################
#
# Live Reload setting
#
########################
configure :development do
  activate :livereload
end


########################
#
# Helper
#
########################

# 自動でimgタグのwidthやheightを指定する
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end


########################
#
# Activate plugins
#
########################
configure :build do
  # activate :minify_css
  # activate :minify_javascript
  # activate :minify_html

  # Enable cache buster
  # activate :asset_hash do |options|
  #   options.ignore = [/^assets\/images\/teaser\/eyecatch\.jpg/, /^assets\/images\/eyecatch\.jpg/]
  # end

  # Use relative URLs
  # activate :relative_assets
end



########################
#
# S3sync Setting
#
########################
activate :s3_sync do |config|

  # Profile name
  profile_name = 's3-prism-nukos-kitchen'

  # Get credential
  credential = AWS::Core::CredentialProviders::
                SharedCredentialFileProvider
                .new(profile_name: profile_name)
                .get_credentials

  # S3Sync config
  config.bucket                     = 'prism.nukos.kitchen'
  config.region                     = 'ap-northeast-1'
  config.aws_access_key_id          = credential[:access_key_id]
  config.aws_secret_access_key      = credential[:secret_access_key]
  config.delete                     = true
  config.after_build                = false
  config.prefer_gzip                = true
  config.path_style                 = true
  config.reduced_redundancy_storage = false
  config.acl                        = 'public-read'
  config.encryption                 = false
end
