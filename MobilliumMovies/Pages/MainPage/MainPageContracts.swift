//
//  MainPageContracts.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import Foundation

protocol MainPageViewModelDelegate:AnyObject{
    var delegate:MainPageViewModelProtocol? {get set}
    func fetchDataAtStart()
    func fetchData(page:Int)
    func refresh()
}

protocol MainPageViewModelProtocol:AnyObject{
    func handleOutputs(output:MainPageViewModelOutputs)
}


protocol MainPageRouterProtocol{
    func routeToPage(_ route:MainPageRoutes)
}

enum MainPageViewModelOutputs{
    case anyErrorOccured(String)
    case appendUpComingResults([MoviePresentation])
    case appendNowPlayingResults([MoviePresentation])
    case refreshUpComingResults([MoviePresentation])
}

enum MainPageRoutes{
    case toDetailPage(MoviePresentation)
}
