//
//  MoviesSelectViewController.swift
//  uikit-avengers-idtest
//
//  Created by Andres Rechimon on 18/08/2024.
//

import UIKit

class MoviesSelectViewController: UIViewController {
    private var viewModel: MoviesSelectViewModel = MoviesSelectViewModel()
    
    private lazy var headerContainerView: AVHeaderView = {
        let view = AVHeaderView(frame: .zero)
        
        return view
    }()
    
    private lazy var avengersMoviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AvengersMoviesTableViewCell.self, forCellReuseIdentifier: "AvengersMoviesTableViewCell")
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        getMovies()
        setupView()
    }
    
    func getMovies(){
        NetworkManager.getMovies() {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let movies):
                print(movies.results)
                viewModel.movies = movies.results
                DispatchQueue.main.async {
                    self.avengersMoviesTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupView() {
        view.addSubview(headerContainerView)
        view.addSubview(avengersMoviesTableView)
        
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            avengersMoviesTableView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor),
            avengersMoviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            avengersMoviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avengersMoviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension MoviesSelectViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvengersMoviesTableViewCell", for: indexPath) as! AvengersMoviesTableViewCell
        cell.selectionStyle = .none
        let model = viewModel.movies[indexPath.row]
        cell.setup(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieSelectedViewController(title: viewModel.movies[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
