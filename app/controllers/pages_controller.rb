class PagesController < ApplicationController
  skip_before_filter :require_current_user
  skip_before_filter :require_current_account
end
