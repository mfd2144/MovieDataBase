//
//  Router.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import Foundation
import UIKit
final class MainPageRouter: MainPageRouterProtocol{
    var navigationController:UINavigationController!
    func routeToPage(_ route: MainPageRoutes) {
        switch route {
        case .toDetailPage(let moviePresentation):
            let detailPage = DetailPageBuilder.make(movie: moviePresentation)
            navigationController.pushViewController(detailPage, animated: true)
        }
    }
}
