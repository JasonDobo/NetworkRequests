# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'NetworkRequests' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NetworkRequests
  pod 'SBTUITestTunnelServer'
  pod 'GCDWebServer', :inhibit_warnings => true

  target 'NetworkRequestsTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'SBTUITestTunnelClient'
  end

  target 'NetworkRequestsUITests' do
    inherit! :complete

    # Pods for testing
    pod 'SBTUITestTunnelClient'
  end

end
