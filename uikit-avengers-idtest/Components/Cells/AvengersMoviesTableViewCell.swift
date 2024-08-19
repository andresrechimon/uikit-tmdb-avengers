//
//  AvengersMoviesTableViewCell.swift
//  uikit-avengers-idtest
//
//  Created by Andres Rechimon on 18/08/2024.
//

import UIKit
import SDWebImage

class AvengersMoviesTableViewCell: UITableViewCell {
    var imageURL: URL?
    
    private lazy var movieImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: ConstantImage.notFound)
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        applyStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyStyle() {
        self.addSubview(movieImageView)
        self.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: self.topAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    func setup(model: Movie) {
        setImage(image: model.posterPath ?? "")
        nameLabel.text = model.title
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.red,
            .foregroundColor : UIColor.black,
            .strokeWidth : -2.0,
            ]

        nameLabel.attributedText = NSAttributedString(string: model.title ?? "", attributes: strokeTextAttributes)
    }
    
    private func setImage(image: String) {
        if image != "" {
            imageURL = AVImage.makeImageURL(image)
            movieImageView.sd_setImage(with: imageURL)
        } else {
            movieImageView.image = UIImage(named: ConstantImage.notFound)
        }
    }
}
