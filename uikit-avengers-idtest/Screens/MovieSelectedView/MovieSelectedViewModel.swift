//
//  MovieSelectedViewModel.swift
//  uikit-avengers-idtest
//
//  Created by Andres Rechimon on 18/08/2024.
//

import Foundation

class MovieSelectedViewModel {
    func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstants.shared.imageServerAddress)\(imageCode)")
    }
}
