//
//  MovieTableViewCell.swift
//  MVCApp
//
//  Created by iAskedYou2nd on 7/1/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let reuseID = "\(MovieTableViewCell.self)"

    var posterImageView: UIImageView = {
        let imageview = UIImageView(frame: .zero)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        imageview.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return imageview
    }()
    
    var titleLabel: UILabel = {
        return UILabel(numLine: 0)
    }()
    
    var releaseDateLabel: UILabel = {
        return UILabel(numLine: 0)
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        let stackview = UIStackView(frame: .zero)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        
        stackview.addArrangedSubview(self.titleLabel)
        stackview.addArrangedSubview(self.releaseDateLabel)
        
        self.contentView.addSubview(stackview)
        self.contentView.addSubview(self.posterImageView)
        
        stackview.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        stackview.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        stackview.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.posterImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.posterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.posterImageView.leadingAnchor.constraint(equalTo: stackview.trailingAnchor, constant: 8).isActive = true
    }
    
    func configure(movie: Movie) {
        
        self.titleLabel.text = movie.title
        self.releaseDateLabel.text = movie.releaseDate
        
        if let data = ImageCache.shared.getData(url: movie.posterURL) {
            self.posterImageView.image = UIImage(data: data)
            return
        }
        
        self.posterImageView.image = UIImage(named: "question-mark")
        
        NetworkManager.shared.getRawData(urlStr: NetworkConstants.imageBase + movie.posterURL) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    ImageCache.shared.setData(url: movie.posterURL, data: data)
                    self.posterImageView.image = UIImage(data: data)
                }) 
            case .failure(let error):
                print(error)
            }
        }
        
         
        
    }

}
