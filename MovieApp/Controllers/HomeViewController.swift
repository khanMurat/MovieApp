//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import UIKit

private let identifier = "HomeCell"

class HomeViewController : UICollectionViewController {
    
    //MARK: - Properties
    
    private var movies = [Movie](){
        didSet{collectionView.reloadData()}
    }
    var pageNumber = 3
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        fetchMovies(pageNum: pageNumber)
    }
    
    //MARK: - Helpers
    
    func configureCollectionView(){
        
        navigationItem.title = "Home"
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: identifier)
        
        collectionView.backgroundColor = .black
    }
    
    //MARK: - API
    
    func fetchMovies(pageNum:Int){
        
        ApiService.fetchMovies(with: pageNum) { result in
                switch result {
                case .success(let movies):
                    self.movies = movies.results
                    self.collectionView.reloadData()
                case .failure(let error):
                    self.showMessage(withTitle: "ERROR", message: error.localizedDescription)
                }
            }
        }
    }

//MARK: - UICollectionViewDelegate
extension HomeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        let controller = DetailViewController(collectionViewLayout: layout)
        controller.movie = movies[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UICollectionViewDataSource

extension HomeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeCell
        cell.viewModel = HomeViewModel(movie: movies[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 2)/3
        
        let height = width + 8 + 40 + 40
        
        return CGSize(width: width, height: height)
    }
}

//MARK: - UIScrollViewDelegate

extension HomeViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let visibleHeight = scrollView.bounds.height
        
        if offsetY > contentHeight - visibleHeight && scrollView == collectionView {
                fetchMoreMovie()
            }
        }
    func fetchMoreMovie(){
        showLoader(true)
        pageNumber += 1
        print(pageNumber)
        ApiService.fetchMovies(with: pageNumber) { result in
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        self.movies += movies.results
                        self.showLoader(false)
                    }
                case .failure(let error):
                    self.showLoader(false)
                    self.showMessage(withTitle: "ERROR", message: error.localizedDescription)
            }
        }
    }
}
