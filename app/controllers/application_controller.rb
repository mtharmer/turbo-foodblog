# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do
    redirect_to root_url, alert: t('cancan_not_found')
  end
end
