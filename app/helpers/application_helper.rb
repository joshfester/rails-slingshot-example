module ApplicationHelper
  include Pagy::Frontend

  def active_link_to(name = nil, options = nil, **html_options, &block)
    options = block_given? ? name : options

    if current_page?(options)
      html_options[:class] = class_names(html_options[:class], :active)
      html_options[:aria] = html_options.fetch(:aria, {}).merge(current: :page)
    end

    if block_given?
      link_to options, html_options, &block
    else
      link_to name, options, html_options
    end
  end

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
