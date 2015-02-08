module StaticHelper

  def image_paths
    to_return = {}
    ['up-arrow-icon-small.png'].each do |path|
      to_return[path] = image_path(path)
    end
    to_return
  end
end
