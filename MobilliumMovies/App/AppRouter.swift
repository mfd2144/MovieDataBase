//
//  AppRouter.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import UIKit

final class AppRouter{
    var window: UIWindow?
    
     func start(_ scene:UIWindowScene){
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
         window?.rootViewController = MainPageBuilder.make()
         window?.makeKeyAndVisible()
    }
    func getTopVC()->UIViewController?{
        guard let topController = window?.rootViewController else {return nil}
        return getVisibleViewControllerFrom(vc: topController)
    }
    
    private func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {
        if vc.isKind(of: UINavigationController.self) {
            let navigationController = vc as! UINavigationController
            return navigationController.visibleViewController!
        } else if vc.isKind(of: UITabBarController.self) {
            let tabBarController = vc as! UITabBarController
           return tabBarController.selectedViewController!
        } else {
            if let presentedViewController = vc.presentedViewController {
                return presentedViewController
            } else {
                return vc
            }
        }
    }
}
