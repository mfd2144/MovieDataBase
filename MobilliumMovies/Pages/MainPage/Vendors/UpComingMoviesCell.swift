//
//  UpComingMoviesCell.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 17.04.2022.
//

import UIKit

class UpComingMoviesCell: UICollectionViewCell {
    var movie:MoviePresentation?{
        didSet{
            setCell()
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImage.image = UIImage.init(named: "ege")
    }
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        view.layer.addBottomLine()
    }
    
    private func setCell() {
        guard let movie = movie else {
            return
        }
        let year = Date.yearString(date: movie.releaseDate)
        movieTitle.text = "\(movie.title) (\(year))"
        movieDescription.text = movie.overview
        dateLabel.text = Date.dateStringWithDots(date: movie.releaseDate)
        guard let url = URL.init(string: movie.imageUrl) else {return}
        movieImage.sd_setImage(with: url)
    }

}
