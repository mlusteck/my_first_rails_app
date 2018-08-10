module ApplicationHelper
  def decoration_string(len)
    my_string = ""
    (0...len).each {|n| my_string += ('a'..'z').to_a.sample }
    my_string
  end

  #test if asset exists (for displaying images)
  def asset_exist?(path)
    if Rails.configuration.assets.compile
      Rails.application.precompiled_assets.include? path
    else
      Rails.application.assets_manifest.assets[path].present?
    end
  end
end
