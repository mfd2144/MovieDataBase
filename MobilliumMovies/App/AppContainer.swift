//
//  AppContainer.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import Foundation

let appContainer = AppContainer()
final class AppContainer {
    let appRouter = AppRouter()
    let networkLayerManager = NetworkLayerManager()
}
