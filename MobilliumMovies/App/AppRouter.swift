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
}
