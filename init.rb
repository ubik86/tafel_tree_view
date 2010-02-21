%w[tafel_tree_view].each { |file| 
  require File.join( File.dirname(__FILE__), "lib",file) 
}

# install files
unless File.exists?(RAILS_ROOT + '/public/javascripts/tafel_tree_view/Tree-optimized.js')
  ['/public', '/public/javascripts/tafel_tree_view', '/public/stylesheets/tafel_tree_view', '/public/images/tafel_tree_view'].each do |dir|
    source = File.join(directory,dir)
    dest = RAILS_ROOT + dir
    FileUtils.mkdir_p(dest)
    FileUtils.cp(Dir.glob(source+'/*.*'), dest)
  end
end


ActionView::Base.send(:include, Ubik86::TafelTree::View)
ActiveRecord::Base.send(:include, Ubik86::TafelTree::Model)