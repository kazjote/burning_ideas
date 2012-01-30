require 'sprockets'

Sprockets.register_engine '.haml', Tilt::HamlTemplate

task :compile_assets do
  environment = Sprockets::Environment.new
  %w{javascripts stylesheets templates images}.each do |path|
    environment.append_path path
  end

  assets_to_compile = %w{application.js app.css index.html}
  Dir["images/*"].each do |image_path|
    assets_to_compile << File.basename(image_path)
  end

  assets_to_compile.each do |asset_name|
    asset = environment.find_asset(asset_name)
    raise "Could not fetch asset #{asset_name}!" unless asset
    asset.write_to "backend/resources/public/#{asset_name}"
  end
end

task :default => [:compile_assets] do
end
