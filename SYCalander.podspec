

Pod::Spec.new do |s|
  s.name        	     = 'SYCalander'
  s.version				 = '0.1.0'
  s.summary         	 = 'Calander UI'

  s.homepage       	     = 'https://github.com/Ambtion/SYCalander'
  s.license      		 = "MIT"
  s.author       		 = { "ambtion" => "kequ1988@gmail.com"}
  s.source       		 = { :git => 'https://github.com/Ambtion/SYCalander.git'}
  s.platform    		 = 	:ios, "8.0"

  s.public_header_files  = 'SYCalander/*.h'
  s.source_files   		 = "SYCalander", "SYCalander/*.{h,m}"
  s.resources 			 = 'SYCalander/Resource/*.png'

  s.dependency 				"Masonry", "1.0.2"
  s.dependency 				"UIViewAdditions","1.0.0"
  s.framework    = 'UIKit'
  s.requires_arc		 = true

end
