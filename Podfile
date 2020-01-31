workspace 'DB1-Guidelines'
inhibit_all_warnings!

# Adicionar o target para cada novo projeto adicionado ao workspace!

# Properties

def testing
   pod 'Hippolyte'
end

# Application

target 'Demo' do
	platform :ios, '11.0'
	project 'Demo/Demo.xcodeproj'
end

# Features

target 'EnvironmentDescription' do 
  platform :ios, '11.0'
  project 'EnvironmentDescription/EnvironmentDescription.xcodeproj'
end

target 'SwiftUIDemo' do 
  platform :ios, '11.0' # a plataforma mínima é 11.0 apenas para manter a compatibilidade com o projeto principal (Demo)
  project 'SwiftUIDemo/SwiftUIDemo.xcodeproj'
end

# DB1 Libs

target 'Core' do 
  platform :ios, '11.0'
  project 'Core/Core.xcodeproj'
end

target 'KeychainService' do
  platform :ios, '11.0'
  project 'KeychainService/KeychainService.xcodeproj'
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

target 'Resources' do
	platform :ios, '13.0'
	project 'Resources/Resources.xcodeproj'
end
	
