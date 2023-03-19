# frozen_string_literal: true

module Layout
  class FlashComponent < ApplicationComponent
    def initialize(flash: nil)
      @flash = flash
    end

    def content
      @content ||= @flash[:alert] ||= @flash[:notice]
    end

    def render?
      content.present?
    end

    def icon_class
      "circle-info"
    end

    def alert_class
      "info"
    end
  end
end
