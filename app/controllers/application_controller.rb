class ApplicationController < ActionController::Base
  # FUNGSI DARI METHOD INI APA? KARNA INI KAN ISINYA SUPER
  def after_sign_in_path_for(resource)
    super
  end
end
