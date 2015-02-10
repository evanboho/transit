module StaticHelper

  def image_paths
    to_return = {}
    ['up-arrow-icon-small.png'].each do |path|
      to_return[path] = image_path(path)
    end
    to_return
  end

  def nav_logo_specifier
    return if params[:controller] == 'static'
    return ": <span class='specifier'>Agencies</span>".html_safe if defined? bootstrap_data
    ": <span class='specifier'>Near Me</span>".html_safe
  end
end
