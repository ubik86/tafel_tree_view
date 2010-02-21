module Ubik86
  module TafelTree
    module View
    
      def tafel_tree_display(tree, div ,options = {})
        default_options = "{'generate' : true,'imgBase' :'images/tafel_tree_view/', 'defaultImg' : 'page.gif','defaultImgOpen' : 'imgfolder.gif', 'defaultImgClose' : 'folder.gif'}"
        options.empty? ? options = default_options : options = options.to_json

        out = []
        tree = "var struct = eval(#{tree.to_json});"
        tafel = "var tree = new TafelTree(\'#{div}\', struct,#{options});"
        out << content_tag(:div,javascript_tag(tree + tafel),:id => div)

        out
      end
    
      def tafel_tree_include
        [stylesheet_link_tag('tafel_tree_view/tree'), javascript_include_tag('tafel_tree_view/Tree-optimized') ]
      end
    end
    
    
    module Model
      def self.included(base)
        base.extend Methods
      end
      
      module Methods
        
        def acts_as_tafel_tree
          include Ubik86::TafelTree::Model::InstanceMethods
        end
      end
      
      module InstanceMethods
        def tafel_tree_build(*args,&block)
          options = args.extract_options!
          
          raise "Nie obslugiwany typ tree_node" if self.methods.grep(/children/).empty?
          
          hash = {:id => self.id}
          hash[:txt] =  yield self 
          hash[:items] = make_hash_array(self.children,block)
          return hash
        end
        
        private 
        def make_hash_array(roots,block)
          tab = Array.new
          roots.each do |root|
            hash = {}
            hash[:id]  = root.id
            hash[:txt] = block.call(root)
            children = root.children
            if children.length > 0
              hash[:items] = make_hash_array(children,block)
            end
            tab << hash
          end
          tab
        end
      end
    end
  end
end