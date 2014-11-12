require 'slim'
require 'dotenv'

Dotenv.load

cname = 'ci2go.com'

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :ogp do |ogp|
  ogp.namespaces = {
    fb: {
      admins: '1034163350',
      app_id: '389393831218391'
    },
    og: {
      title: 'CI2Go The CircleCI Client for iPhone and iPad',
      site_name: 'CI2Go',
      locale: 'en_US',
      type: 'website',
      description: 'CI2Go is a CircleCI Client for iPhone and iPad.',
      image: {
        '' => "http://#{cname}/images/og.png",
        width: 1200,
        height: 630
      }
    }
  }
  ogp.base_url = "http://#{cname}/"
end

# Build-specific configuration
configure :build do
  ignore '.DS_Store'
  ignore '.*.swp'
  ignore '_drafts'
  ignore 'redirect.html'

  activate :favicon_maker, :icons => {
    "favicon-hires.png" => [
      { icon: "apple-touch-icon-152x152-precomposed.png" },
      { icon: "apple-touch-icon-144x144-precomposed.png" },
      { icon: "apple-touch-icon-120x120-precomposed.png" },
      { icon: "apple-touch-icon-114x114-precomposed.png" },
      { icon: "apple-touch-icon-76x76-precomposed.png" },
      { icon: "apple-touch-icon-72x72-precomposed.png" },
      { icon: "apple-touch-icon-60x60-precomposed.png" },
      { icon: "apple-touch-icon-57x57-precomposed.png" },
      { icon: "apple-touch-icon-precomposed.png", size: "57x57" },
      { icon: "apple-touch-icon.png", size: "57x57" },
      { icon: "favicon-196x196.png" },
      { icon: "favicon-160x160.png" },
      { icon: "favicon-96x96.png" },
      { icon: "mstile-144x144", format: "png" }
    ],
    "favicon-lores.png" => [
      { icon: "favicon-32x32.png" },
      { icon: "favicon-16x16.png" },
      { icon: "favicon.png", size: "16x16" },
      { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" }
    ]
  }

end

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-56666052-2'
end

activate :deploy do |deploy|
  IO.write "source/CNAME", cname
  deploy.method = :git
  deploy.branch = 'gh-pages'
  deploy.remote = "https://#{ENV['GH_TOKEN']}@github.com/ngs/#{cname}.git"
end
