//
//  OtherDetailsCell.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 18.04.2022.
//

import UIKit

class OtherDetailsCell: UITableViewCell {
    static let id = "OtherDetailsCell"
    var movie:MoviePresentation!{
        didSet{
            setMovieData()
        }
    }
    private let horizontalStack:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        return stack
    }()
    
    private let imdbImageView: UIImageView = {
        let iv = UIImageView(image: UIImage.init(named: "imdb"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let starImageView: UIImageView = {
        let iv = UIImageView(image: UIImage.init(named: "star"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let rateStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.spacing = 3
        stack.axis = .horizontal
        return stack
    }()
    
    private let rateLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let rateLabel2:UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "/ 10"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    private let yellowDot:UIImageView = {
        let iv = UIImageView()
        let image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(red: 238/255.0, green: 197/255.0, blue: 72/255.0, alpha: 1.0))
        iv.image = image
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let dateLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setCell()
        // Configure the view for the selected state
    }
    
    private func setCell(){
        backgroundColor = .white
        rateStack.addArrangedSubview(rateLabel)
        rateStack.addArrangedSubview(rateLabel2)
        let views:[UIView] = [imdbImageView,starImageView,rateStack,yellowDot,dateLabel]
        for view in views {
            horizontalStack.addArrangedSubview(view)
        }
        addSubview(horizontalStack)
        addSubview(titleLabel)
     
        NSLayoutConstraint.activate([
            horizontalStack.widthAnchor.constraint(equalToConstant: 250),
            horizontalStack.leadingAnchor.constraint(equalTo:leadingAnchor,constant: 20 ),
            horizontalStack.heightAnchor.constraint(equalToConstant: 40),
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            yellowDot.heightAnchor.constraint(equalToConstant: 5),
            yellowDot.centerYAnchor.constraint(equalTo: horizontalStack.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor,constant: -40),
            titleLabel.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    private func setMovieData(){
        rateLabel.text = String(movie.rating)
        dateLabel.text = Date.dateStringWithDots(date: movie.releaseDate)
        titleLabel.text = "\(movie.title) (\(Date.yearString(date: movie.releaseDate)))"
    }

}
