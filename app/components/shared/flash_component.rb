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

  def alert_class
    if @flash[:alert].present?
      'danger'
    else
      'info'
    end
  end

end
