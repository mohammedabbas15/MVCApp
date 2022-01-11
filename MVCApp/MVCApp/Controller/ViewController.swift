//
//  ViewController.swift
//  MVCApp
//
//  Created by iAskedYou2nd on 6/30/21.
//

import UIKit

// https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/471.png

// Implement tableview
// Create CustomCell to show move info
// Showcase lazy image fetching
// Image Caching
// prefetching data/pagination




class ViewController: UIViewController {

//    lazy var imageView: UIImageView = {
//        let imageView = UIImageView(frame: .zero)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        imageView.backgroundColor = .red
//        return imageView
//    }()
    
    lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseID)
        // Eventual prefetching
        return tableview
    }()
    
    var movies: [Movie] = [] {
        didSet {
            guard oldValue != movies else { return }
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    let networkManager = NetworkManager(session: URLSession.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableview)
        self.tableview.bindToSuperView()
        
//        self.view.addSubview(self.imageView)
//        self.imageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
//        self.imageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        <#code#>
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.networkManager.getPage(urlStr: NetworkConstants.moviePopular) { (result) in
            switch result {
            case .success(let page):
                print(page)
                self.movies = page.results
            case .failure(let error):
                print(error)
            }
        }
        
        
//        self.networkManager.getImage(urlStr: NetworkConstants.glaceonPic) { (result) in
//
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    self.imageView.image = UIImage(data: data)
//                }
//            case .failure(let error):
//                print(error)
//            }
//
//
//
//        }
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        <#code#>
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        <#code#>
//    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseID, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(movie: self.movies[indexPath.row])
        return cell
    }
    
}
