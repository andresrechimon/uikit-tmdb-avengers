//
//  NetworkManager.swift
//  uikit-avengers-idtest
//
//  Created by Andres Rechimon on 18/08/2024.
//

import UIKit

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class NetworkManager {
    
    static func getMovies(completionHandler: @escaping (_ result: Result<MovieModel, NetworkError>) -> Void) {
        if NetworkConstants.shared.apiKey.isEmpty {
            print("<!> API KEY is Missing <!>")
            print("<!> Get One from: https://www.themoviedb.org/ <!>")
            return
        }
        
        let urlString = NetworkConstants.shared.serverAddress +
        "search/movie?api_key=" +
        NetworkConstants.shared.apiKey +
        "&with_companies=420&query=avengers+marvel"
        print(urlString)
                
        guard let url = URL(string: urlString) else {
            completionHandler(Result.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(MovieModel.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                print(err.debugDescription)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}
