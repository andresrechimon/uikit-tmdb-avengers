//
//  MovieSelectedViewController.swift
//  uikit-avengers-idtest
//
//  Created by Andres Rechimon on 18/08/2024.
//

import UIKit
import SDWebImage

class MovieSelectedViewController: UIViewController {
    private var titleSelected: Movie
    var imageURL: URL?
    
    private lazy var headerTitleView: AVHeaderView = {
        let view = AVHeaderView(frame: .zero)
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: ConstantImage.backBtn), for: .normal)
        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        return button
    }()
    
    @objc func goBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private lazy var titleNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = titleSelected.title
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.red,
            .foregroundColor : UIColor.black,
            .strokeWidth : -2.0,
            ]

        label.attributedText = NSAttributedString(string: titleSelected.title!, attributes: strokeTextAttributes)
        
        return label
    }()
    
    private lazy var coverImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 125)
        ])
        
        return image
    }()
    
    private func setImage(image: String) {
        if image != "" {
            imageURL = AVImage.makeImageURL(titleSelected.posterPath ?? "")
            coverImageView.sd_setImage(with: imageURL)
        } else {
            coverImageView.image = UIImage(named: ConstantImage.notFound)
        }
    }
    
    private lazy var identificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.text = "ID: \(titleSelected.id)"
        
        return label
    }()
    
    private lazy var popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.text = "Popularidad: \(titleSelected.popularity ?? 0)"
        
        return label
    }()
    
    private lazy var votesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.text = "Votos: \(titleSelected.voteCount)"
        
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.text = "⭐️: \(self.titleSelected.voteAverage)/10"
        
        return label
    }()
    
    private lazy var releaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.text = "Lanzamiento: \(self.titleSelected.releaseDate ?? "?")"
        
        return label
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.red,
            .foregroundColor : UIColor.black,
            .strokeWidth : -2.0,
            ]

        label.attributedText = NSAttributedString(string: "DESCRIPCIÓN", attributes: strokeTextAttributes)
        
        return label
    }()
    
    private lazy var descriptionBodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 16)
        label.text = self.titleSelected.overview
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    required init(title: Movie) {
        self.titleSelected = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.addSubview(headerTitleView)
        view.addSubview(backButton)
        view.addSubview(titleNameLabel)
        view.addSubview(coverImageView)
        view.addSubview(identificationLabel)
        view.addSubview(popularityLabel)
        view.addSubview(votesLabel)
        view.addSubview(ratingLabel)
        view.addSubview(releaseLabel)
        view.addSubview(descriptionTitleLabel)
        view.addSubview(descriptionBodyLabel)
        
        setImage(image: titleSelected.posterPath ?? "")
        
        NSLayoutConstraint.activate([
            headerTitleView.topAnchor.constraint(equalTo: view.topAnchor),
            headerTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: headerTitleView.bottomAnchor,constant: 15),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            titleNameLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            titleNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: titleNameLabel.bottomAnchor, constant: 20),
            coverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            identificationLabel.topAnchor.constraint(equalTo: coverImageView.topAnchor),
            identificationLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 5),
            identificationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            popularityLabel.topAnchor.constraint(equalTo: identificationLabel.bottomAnchor, constant: 5),
            popularityLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 5),
            popularityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            votesLabel.topAnchor.constraint(equalTo: popularityLabel.bottomAnchor, constant: 5),
            votesLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 5),
            votesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            ratingLabel.topAnchor.constraint(equalTo: votesLabel.bottomAnchor, constant: 5),
            ratingLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 5),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            releaseLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 5),
            releaseLabel.bottomAnchor.constraint(equalTo: coverImageView.bottomAnchor),
            
            descriptionTitleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 15),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionBodyLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10),
            descriptionBodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
