//
//  AVSelectedHeaderView.swift
//  uikit-avengers-idtest
//
//  Created by Andres Rechimon on 18/08/2024.
//

import UIKit

class AVHeaderView: UIImageView {
    
    private lazy var redFilterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red.withAlphaComponent(0.8)
        
        return view
    }()
    
    private lazy var titleLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: ConstantImage.avHeader)
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: ConstantImage.avSelectedHeader)
        
        self.addSubview(redFilterView)
        redFilterView.addSubview(titleLogo)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 170),
            
            redFilterView.topAnchor.constraint(equalTo: self.topAnchor),
            redFilterView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            redFilterView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            redFilterView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            titleLogo.bottomAnchor.constraint(equalTo: redFilterView.bottomAnchor, constant: -10),
            titleLogo.centerXAnchor.constraint(equalTo: redFilterView.centerXAnchor)
        ])
    }
}
