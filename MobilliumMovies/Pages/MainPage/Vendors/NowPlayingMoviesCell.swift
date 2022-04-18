//
//  NowPlayingCell.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 17.04.2022.
//

import UIKit
import SDWebImage

class NowPlayingMoviesCell: UICollectionViewCell {
    var movie:MoviePresentation?{
        didSet{
            setCell()
        }
    }
    let movieImage:UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        return iv
    }()
    let title:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let movieDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        setViews()
    }
    private func setViews(){
        addSubview(movieImage)
        addSubview(title)
        addSubview(movieDescription)
        NSLayoutConstraint.activate([
            movieImage.heightAnchor.constraint(equalTo: heightAnchor),
            movieImage.widthAnchor.constraint(equalTo: widthAnchor),
            movieImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieDescription.heightAnchor.constraint(equalToConstant: 70),
            movieDescription.widthAnchor.constraint(equalTo: widthAnchor,constant: -40),
            movieDescription.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -60),
            movieDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.heightAnchor.constraint(equalToConstant: 50),
            title.widthAnchor.constraint(equalTo: widthAnchor,constant: -40),
            title.bottomAnchor.constraint(equalTo: movieDescription.topAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    private func setCell(){
        guard let movie = movie else {
            return
        }
        let year = Date.yearString(date: movie.releaseDate)
        title.text = "\(movie.title) (\(year))"
        movieDescription.text = movie.overview
        guard let urlString = movie.backDropUrl,let url = URL.init(string: urlString) else {return}
        movieImage.sd_setImage(with: url)
    }
}
