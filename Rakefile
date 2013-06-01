# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'mlp'
  app.icons = ['large_pong_man.png']
  app.device_family = [:iphone, :ipad]

  app.fonts = ['Satisfy.ttf']

  app.pods do
    pod 'NSData+MD5Digest'
    pod 'SVProgressHUD'
    pod 'Reachability'
  end
end
