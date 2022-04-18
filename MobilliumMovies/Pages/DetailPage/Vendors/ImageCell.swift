//
//  ImageCell.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 18.04.2022.
//

import UIKit
import SDWebImage

class ImageCell: UITableViewCell {
    static let id = "ImageCell"
    var urlString:String?
    private let movieImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setImageView()
    }
    private func setImageView(){
        addSubview(movieImage)
        NSLayoutConstraint.activate([
            movieImage.heightAnchor.constraint(equalToConstant: 250),
            movieImage.widthAnchor.constraint(equalTo: widthAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        guard let urlString = urlString ,let url = URL(string: urlString) else {
            return
        }
        movieImage.sd_setImage(with: url)
    }
    
}
