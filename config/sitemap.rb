# run this with rake sitemap:refresh:no_ping
# Set the host name for URL creation
host = ENV.fetch("HOST_NAME").present? ? ENV.fetch("HOST_NAME") : "localhost"
protocol = Rails.env.production? ? "https://" : "http://"
SitemapGenerator::Sitemap.default_host = protocol + host
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add root_url, changefreq: nil, priority: nil
end
