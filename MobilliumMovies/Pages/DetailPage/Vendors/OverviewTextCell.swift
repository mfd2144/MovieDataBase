//
//  OverviewTextCell.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 18.04.2022.
//

import UIKit

class OverviewTextCell: UITableViewCell {
    static let id = "OverviewTextCell"
    var movieOverview:String?{
        didSet{
            setMovieData()
        }
    }
   private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
       label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: heightAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor,constant: -40)
        ])

    }

    private func setMovieData(){
        guard let movieOverview = movieOverview else {
            return
        }
        descriptionLabel.text = movieOverview 
    }
}
