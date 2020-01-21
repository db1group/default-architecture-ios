workspace 'DB1-Guidelines'
inhibit_all_warnings!

# Adicionar o target para cada novo projeto adicionado ao workspace!

def testing
   pod 'Hippolyte'
end

target 'LocalStore' do
  platform :ios, '11.0'
  project 'LocalStore/LocalStore.xcodeproj'
  
  target 'LocalStoreTests' do
    inherit! :search_paths
    project 'LocalStore/LocalStore.xcodeproj'
  end
end

target 'Networking' do
  platform :ios, '13.0'
  project 'Networking/Networking.xcodeproj'

  target 'NetworkingTests' do
    inherit! :search_paths
    project 'Networking/Networking.xcodeproj'
    testing
  end
end

# Application

target 'Demo' do
	platform :ios, '13.0'
	project 'Demo/Demo.xcodeproj'

	testing
end