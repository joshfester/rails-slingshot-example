# frozen_string_literal: true

module Layout
  class MetaTagsComponent < ApplicationComponent
    def initialize(
      title:,
      description:,
      keywords:,
      canonical:,
      noindex:,
      og_title:,
      og_site_name:,
      og_url:,
      og_description:,
      og_type:,
      og_image:
    )
      @site_name = "MVP"
      @title = title
      @description = description
      @keywords = keywords
      @canonical = canonical
      @noindex = noindex
      @og_title = og_title
      @og_site_name = og_site_name
      @og_url = og_url
      @og_description = og_description
      @og_type = og_type
      @og_image = og_image
    end

    def title
      "#{@title} | #{@site_name}" if @title.present?
      @site_name
    end

    def og_title
      @og_title ||= title
    end

    def og_site_name
      @og_site_name ||= @site_name
    end

    def og_url
      @og_url ||= helpers.url_for
    end

    def og_description
      @og_description ||= @description
    end

    def og_type
      @og_type ||= "website"
    end
  end
end
