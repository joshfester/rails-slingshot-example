module ApplicationHelper
  include Pagy::Frontend

  def set_meta_tags(
    title: nil,
    description: nil,
    keywords: nil,
    canonical: nil,
    noindex: nil,
    og_title: nil,
    og_site_name: nil,
    og_url: nil,
    og_description: nil,
    og_type: nil,
    og_image: nil
  )
    content_for :meta_title, title
    content_for :meta_description, description
    content_for :meta_keywords, keywords
    content_for :meta_canonical, canonical
    content_for :meta_noindex, noindex
    content_for :meta_og_title, og_title
    content_for :meta_og_site_name, og_site_name
    content_for :meta_og_url, og_url
    content_for :meta_og_description, og_description
    content_for :meta_og_type, og_type
    content_for :meta_og_image, og_image
  end
end
