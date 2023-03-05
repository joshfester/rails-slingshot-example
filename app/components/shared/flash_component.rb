# frozen_string_literal: true

class Shared::FlashComponent < ApplicationComponent

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
    if @flash[:alert].present?
      'triangle-exclamation'
    else
      'circle-info'
    end
  end

  def alert_class
    if @flash[:alert].present?
      'danger'
    else
      'info'
    end
  end

end
