# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
Bundler.require

require 'sugarcube-repl'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'mlp'
  app.prerendered_icon = true
  app.icons = ['large_pong_man.png']
  app.device_family = [:iphone, :ipad]

  app.seed_id = 'TWQR5PJHCM'
  app.identifier = 'TWQR5PJHCM.com.pachun.mlpcastle'
  app.codesign_certificate = 'iPhone Developer: Nicholas Pachulski (3AN7NHZ6WD)'
  app.provisioning_profile = '/Users/pachun/Library/MobileDevice/Provisioning Profiles/AC5F56C1-9BD8-4327-AD3C-530295F0D789.mobileprovision'

  app.testflight.sdk = 'vendor/TestFlight'
  app.testflight.api_token = 'bd6f5448b7bf7ea450d8649b1bb280a6_NDM5NjY1MjAxMi0wNS0xNCAwNDowNzo1My41MjAyMzU'
  app.testflight.team_token = '3d16e5ffd0bb2878102deabf5a68bd28_ODk5NjYyMDEyLTA1LTE0IDA0OjIxOjA0LjI4OTM4Ng'
  app.testflight.distribution_lists = ['Castle']

  app.frameworks += %W(QuartzCore CoreGraphics)

  app.entitlements['get-task-allow'] = true

  app.fonts = ['Satisfy.ttf']

  app.pods do
    pod 'NSData+MD5Digest'
    pod 'SVProgressHUD'
    pod 'Reachability'
    pod 'MFSideMenu'
    pod 'CKCalendar'
  end
end
