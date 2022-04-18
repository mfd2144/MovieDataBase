//
//  MainPageBuilder.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import Foundation
import UIKit

final class MainPageBuilder{
    static func make()->UIViewController{
        let view = MainPageView(collectionViewLayout:UICollectionViewLayout())
        let viewModel = MainPageViewModel()
        let router = MainPageRouter()
        view.viewModel = viewModel
        viewModel.delegate = view
        viewModel.router = router
        viewModel.networklayerManager = appContainer.networkLayerManager
        let navigationController = UINavigationController(rootViewController: view)
        router.navigationController = navigationController
        return navigationController
    }
}
