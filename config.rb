require 'uri'

activate :autoprefixer

configure :development do
  activate :livereload
end

activate :i18n, :langs => [:it]
activate :directory_indexes
activate :dato,
  domain: 'admin.luciaricciardi.it',
  token: "1oi234h2e8qhxc9iwjdqol2j390ocjihqwod91j3o09qiwuilkdjsa",
  base_url: 'http://www.luciaricciardi.it'

set :url_root, 'http://luciaricciardi.it'

ignore "/pathology.html"
ignore "/treatment.html"

dato.pathologies.each do |id, pathology|
  proxy "/patologia/#{pathology.slug}/index.html", "/pathology.html", locals: {pathology:pathology}
end

dato.treatments.each do |id, treatment|
  proxy "/trattamento/#{treatment.slug}/index.html", "/treatment.html", locals: {treatment:treatment}
end


set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :partials_dir, 'partials'
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, autolink: true,
               footnotes: true, with_toc_data: true

activate :syntax, line_numbers: false

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :search_engine_sitemap, default_priority: 0.5, default_change_frequency: "weekly"
end


helpers do
  def google_maps_iframe_url(address)
    "https://www.google.com/maps/embed/v1/place?q=" + URI.escape(address) + "&key=AIzaSyCzXMelzq7cZiA3609zBwaZ446i9NwHo1s"
  end

  def google_maps_url(address)
    "https://www.google.com/maps/place/" + URI.escape(address)
  end
end
