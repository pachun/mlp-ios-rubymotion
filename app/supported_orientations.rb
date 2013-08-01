class UINavigationController < UIViewController
  def supportedInterfaceOrientations
    if viewControllers.last.class == GameSetupScreen || viewControllers.last.class == TurnScreen || viewControllers.last.class == GameOverviewScreen
      UIInterfaceOrientationMaskLandscape
    else
      UIInterfaceOrientationMaskPortrait
    end
  end
end

class UITabBarController < UIViewController
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskPortrait
  end
end

# class UIViewController < UIResponder
#   def supportedInterfaceOrientations
#     UIInterfaceOrientationMaskPortrait
#   end
# end
