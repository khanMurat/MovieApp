//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import UIKit
import RealmSwift

class FavoritesViewController : UITableViewController {
    
    
    //MARK: - Properties
    
    let identifier = "FavoriteCell"
    
    let realm = try! Realm()
    
    var favMovies: Results<FavoriteMovie>? {
        didSet {self.tableView.reloadData()}
    }
    
    var movie : Movie?
    
    var viewModel : DetailViewModel?
    
    var service = RealmService()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFavoritesUI()
        getFavorites()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
    }
    
    //MARK: - API
    
    func getFavorites(){
        
        guard let movies = service.filteredFavorites() else {return}
        DispatchQueue.main.async {
            self.favMovies = movies
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Helpers
    
    func configureFavoritesUI(){
        view.backgroundColor = .black
        
        navigationItem.title = "Favorites"
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: identifier)
        tableView.rowHeight = 88
    }
}

//MARK: - UITableViewDatasource

extension FavoritesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favMovies?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FavoriteCell
        guard let favoriteMovie = favMovies?[indexPath.row] else { return cell }
        cell.delegate = self
        cell.viewModel = FavoriteViewModel(favorites: favoriteMovie)
        return cell
    }
}

extension FavoritesViewController : FavoriteCellDelegate {
    func didLike(_ cell: FavoriteCell, favorite: FavoriteMovie) {
        
        guard let viewModel = cell.viewModel else {return}
        
        service.removeFavorite(id: viewModel.id)
        
        self.tableView.reloadData()
    }
}

