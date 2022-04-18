//
//  ViewController.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import UIKit
import Combine

enum MovieItem:Hashable{
    case nowPlayingMoview(MoviePresentation)
    case upComingMovie(MoviePresentation)
}

class MainPageView: UICollectionViewController {
    var viewModel:MainPageViewModelDelegate!
    private let refreshControl = UIRefreshControl()
    private let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()
    private var totalPage = 0
    private var upComingMovieList:[MoviePresentation] = []
    private var nowPlayingMovieList:[MoviePresentation] = []
    private lazy var dataSource = makeDataSource()
    private var pageNumber:Int = 1
    private var pageLockLogic:Bool = false
    // MARK: - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<MovieSection, MovieItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MovieSection, MovieItem>
    
    //MARK: - Life Cycle of controller
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchDataAtStart()
        Animator.sharedInstance.showAnimation()
        setCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationController()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Collection View Components
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) {[unowned self] (collectionView, indexPath, item) in
            switch item{
            case.nowPlayingMoview(let movie):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSection.nowPlaying.cellIdentifier, for: indexPath) as?  NowPlayingMoviesCell else {fatalError()}
                cell.movie = movie
                return cell
            case .upComingMovie(let movie):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSection.upComing.cellIdentifier, for: indexPath) as?  UpComingMoviesCell else {fatalError()}
                cell.movie = movie
                if upComingMovieList.count-indexPath.row <= 1 && pageLockLogic {
                    pageLockLogic = false
                    pageNumber += 1
                    viewModel.fetchData(page: pageNumber)
                }
                return cell
            }
      }
        
        dataSource.supplementaryViewProvider = {[weak self](collectionView,kind,indexPath)->UICollectionReusableView? in
            guard let self = self else {return nil}
            let pageControllerFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PageControllerFooter.reuseIdentifier, for: indexPath) as! PageControllerFooter
            let itemCount = self.nowPlayingMovieList.count
            pageControllerFooter.configure(with: itemCount)
            pageControllerFooter.subscribeTo(subject: self.pagingInfoSubject)
            return pageControllerFooter
        }
        
    return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
      var snapshot = Snapshot()
        snapshot.appendSections(MovieSection.allCases)
        let nowPlayinItem = nowPlayingMovieList.map{ MovieItem.nowPlayingMoview($0) }
        snapshot.appendItems(nowPlayinItem, toSection: MovieSection.nowPlaying)
        let upComingItem = upComingMovieList.map{ MovieItem.upComingMovie($0) }
        snapshot.appendItems(upComingItem, toSection: MovieSection.upComing)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences, completion: nil)
    
  }
  
    private func setCollectionView(){
        collectionView.collectionViewLayout = compositionalLayout()
        collectionView.register(NowPlayingMoviesCell.self, forCellWithReuseIdentifier: MovieSection.nowPlaying.cellIdentifier)
        collectionView.register(UINib(nibName: MovieSection.upComing.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: MovieSection.upComing.cellIdentifier)
        collectionView.register(PageControllerFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PageControllerFooter.reuseIdentifier)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshMovieData(_:)), for: .valueChanged)
        collectionView.showsVerticalScrollIndicator = false
        applySnapshot()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section
        switch section{
        case 0:
           let movie = nowPlayingMovieList[indexPath.row]
            viewModel.toDetailPage(movie)
        case 1:
           let movie = upComingMovieList[indexPath.row]
            viewModel.toDetailPage(movie)
        default:
            break
        }
    }
    
    //Refresh controller
    @objc private func refreshMovieData(_ sender:UIRefreshControl){
        viewModel.refresh()
    }
    private func setNavigationController(){
        navigationController?.navigationBar.isHidden = true
    }
}

extension MainPageView{
    //MARK: - Collection view compositional layout
    func compositionalLayout()->UICollectionViewCompositionalLayout{
        let layout = UICollectionViewCompositionalLayout { [weak self](section,env) -> NSCollectionLayoutSection? in
            guard let self = self else {return nil}
            switch section{
            case 0:
                return self.nowPlayingMovies()
            default:
                return self.upComing()
            
            }
        }
        return layout
    }
    
    private func nowPlayingMovies()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        if let top
            = UIApplication.shared.windows.first?.safeAreaInsets.top {
            item.contentInsets = .init(top: -top, leading: 0, bottom: -40, trailing: 0)
        }else{
            item.contentInsets = .init(top: 0, leading: 0, bottom: -40, trailing: 0)
        }
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let pageControllerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(40))
          let pageController = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: pageControllerSize,
            elementKind: UICollectionView.elementKindSectionFooter ,
            alignment: .bottom)
        
        let section = NSCollectionLayoutSection(group:group )
        section.boundarySupplementaryItems = [pageController]
        section.orthogonalScrollingBehavior = .groupPaging
        section.visibleItemsInvalidationHandler = {[weak self](items, offset, env) in
            guard let self = self else {return}
            let page = round(offset.x / UIScreen.main.bounds.width)
            self.pagingInfoSubject.send(.init(totalPage: self.totalPage, currentPage: Int(page)))
        }
        return section
    }
    
    private func upComing()->NSCollectionLayoutSection{
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:.absolute(140))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group:group )
        return section
    }
}
extension MainPageView:MainPageViewModelProtocol{
    func handleOutputs(output: MainPageViewModelOutputs) {
        Animator.sharedInstance.hideAnimation()
        switch output {
        case .anyErrorOccured(let string):
            DispatchQueue.main.async { [unowned self] in
            let alertController = UIAlertController(title: "Caution", message:string, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel)
            alertController.addAction(action)
            present(alertController, animated: true)
            }
        case .appendUpComingResults(let array):
            DispatchQueue.main.async { [unowned self] in
                upComingMovieList.append(contentsOf: array)
                applySnapshot(animatingDifferences: true)
                pageLockLogic = true
            }
        case .appendNowPlayingResults(let array):
            DispatchQueue.main.async { [unowned self] in
                nowPlayingMovieList = array
                totalPage = array.count
                applySnapshot()
                refreshControl.endRefreshing()
            }
          
        case .refreshUpComingResults(let array):
            DispatchQueue.main.async { [unowned self] in
                upComingMovieList = array
                applySnapshot()
                refreshControl.endRefreshing()
                pageLockLogic = true
                pageNumber = 1
            }
        }
    }
}
