
puts "Deleting files..."
if File.exists?(RAILS_ROOT + '/public/javascripts/tafel_tree_view/Tree-optimized.js')
  ['/public', '/public/javascripts/tafel_tree_view', '/public/stylesheets/tafel_tree_view', '/public/images/tafel_tree_view'].each do |dir|
    dest = RAILS_ROOT + dir
    FileUtils.remove_dir(dest)
  end
end
puts "Files deleted - Uninstallation complete!"
