//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import UIKit
import RealmSwift

private let identifier = "DetailCell"

class DetailViewController : UICollectionViewController {
    
    //MARK: - Properties
    
    let realm = try! Realm()
    
    var movie : Movie? {
        didSet {configureUI()}
    }
    
    let service = RealmService()
 
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        checkMovieLiked()
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        
        navigationItem.title = movie?.originalTitle
        collectionView.backgroundColor = .black
        collectionView.register(DetailCell.self, forCellWithReuseIdentifier: identifier)
        
    }
    
    //MARK: - API
    
    func checkMovieLiked(){
        
        guard let movie = movie else {return}
        service.checkIfMovieLiked(movie: movie) { isLiked in
            self.movie?.didLike = isLiked
        }
    }
}

//MARK: - UICollectionViewDataSource

extension DetailViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DetailCell
        if let movie = movie {
            cell.viewModel = DetailViewModel(movie: movie)
            cell.delegate = self
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}

extension DetailViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        
        let height = view.frame.height
        
        return CGSize(width: width, height: height)
    }
}

extension DetailViewController : DetailCellDelegate {
    func didLike(_ cell: DetailCell, movie: Movie) {
        
        cell.viewModel?.movie.didLike.toggle()
        
        guard let isLike = cell.viewModel?.movie.didLike else {return}
        guard let viewModel = cell.viewModel else {return}
        
        if isLike {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.likeButton.tintColor = .red
            service.addFavorite(id: viewModel.movie.id, movie: viewModel.movie)
        }else{
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.likeButton.tintColor = .white
            service.removeFavorite(id: viewModel.movie.id)
        }
    }
}
