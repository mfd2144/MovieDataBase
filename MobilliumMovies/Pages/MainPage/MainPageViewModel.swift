//
//  MainPage.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import Foundation

final class MainPageViewModel:MainPageViewModelDelegate{
    weak var delegate: MainPageViewModelProtocol?
    var networklayerManager:NetworkLayerManager!{
        didSet{
            networklayerManager.setUp()
        }
    }
    func fetchDataAtStart() {
        callMovies(.nowPlaying(1))
        callMovies(.upComing(1))
    }
    
    func fetchData(page: Int) {
        print(page)
        callMovies(.upComing(page))
    }
    
    func refresh() {
        callMovies(.nowPlaying(1),append:false)
        callMovies(.upComing(1),append:false)
    }
    
    private func callMovies(_ type:MovieType,append:Bool=true){
        networklayerManager.fetchMovies(type: type) {[weak self] movieResult in
            guard let self = self else {return}
            switch movieResult{
            case.failure(let error):
                self.delegate?.handleOutputs(output: .anyErrorOccured(error))
            case .success(let movies):
                switch type {
                case .upComing:
                    append ? self.delegate?.handleOutputs(output: .appendUpComingResults(movies)) : self.delegate?.handleOutputs(output: .refreshUpComingResults(movies))
                case .nowPlaying:
                    //I add just 5 movies because of case
                    let topFiveMovies = Array(movies.prefix(5))
                    self.delegate?.handleOutputs(output: .appendNowPlayingResults(topFiveMovies))
                }
               
            }
        }
    }
    
}
