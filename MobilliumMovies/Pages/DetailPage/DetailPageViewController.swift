//
//  DetailPageViewController.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 17.04.2022.
//

import Foundation
import UIKit

final class DetailPageViewController:UITableViewController{
    var movie:MoviePresentation!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTableView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationView()
    }
    private func setTableView(){
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.id)
        tableView.register(OtherDetailsCell.self, forCellReuseIdentifier: OtherDetailsCell.id)
        tableView.register(OverviewTextCell.self, forCellReuseIdentifier: OverviewTextCell.id)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
    }
    private func setNavigationView(){
        let year = Date.yearString(date: movie.releaseDate)
        title = "\(movie.title) (\(year))"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
extension DetailPageViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.id, for: indexPath) as? ImageCell else {return UITableViewCell()}
            tableView.rowHeight = 250
            cell.urlString = movie.backDropUrl ?? movie.imageUrl
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherDetailsCell.id, for: indexPath) as? OtherDetailsCell else {return UITableViewCell()}
            tableView.rowHeight = 100
            cell.movie = movie
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTextCell.id, for: indexPath) as? OverviewTextCell else {return UITableViewCell()}
            tableView.rowHeight = UITableView.automaticDimension
            cell.movieOverview = movie.overview
            return cell
        default:
           return UITableViewCell()
        }
    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}

