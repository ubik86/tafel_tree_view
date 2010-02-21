
puts "Copying files..."
unless File.exists?(RAILS_ROOT + '/public/javascripts/tafel_tree_view/Tree-optimized.js')
  ['/public', '/public/javascripts/tafel_tree_view', '/public/stylesheets/tafel_tree_view', '/public/images/tafel_tree_view'].each do |dir|
    source = File.join(directory,dir)
    dest = RAILS_ROOT + dir
    FileUtils.mkdir_p(dest)
    FileUtils.cp(Dir.glob(source+'/*.*'), dest)
  end
end
puts "Files copied - Installation complete!"