#
# To learn more about a podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint shaped_plugin_dev.podspec` to validate before publishing.
# Run `pod repo push shaped-specs shaped_plugin.podspec --allow-warnings`
#
Pod::Spec.new do |s|
  s.name             = 'ShapedPluginCamera'
  s.version          = '0.0.1'
  s.summary = 'Uma Plugin para detecção de poses e segmentação usando Shaped SDK.'
  s.description = <<-DESC
    A Shaped Plugin Camera utiliza o Shaped SDK para fornecer recursos avançados de 
    detecção de poses e segmentação de selfies, facilitando a integração em projetos iOS.
  DESC
  s.homepage         = 'https://web.shaped.com.br'
  s.license          = { :file => 'LICENSE' }
  s.author           = { 'Shaped' => 'support@shaped.com.br' }
  s.source           = { :path => '.' }
  s.source_files = 'Shaped/Classes/**/*'
  s.static_framework = true
  s.dependency 'ShapedSDK', '0.0.1'
  s.platform = :ios, '17.0'
end