//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import UIKit

private let identifier = "SearchCell"

class SearchViewController : UITableViewController {
    
    //MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var movies = [Movie](){
        didSet{self.tableView.reloadData()}
    }
            
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchUI()
        setupSearchController()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    //MARK: - API
    
    func searchMovies(text:String){
        
        ApiService.searchMovie(text: text) { result in
            
            switch result{
            case .success(let movies):
                DispatchQueue.main.async {
                    self.movies = movies.results
                }
            case .failure(let error):
                self.showMessage(withTitle: "ERROR", message: error.localizedDescription)
            }
        
        }
    }
    
    //MARK: - Helpers
    
    func configureSearchUI(){
        
        view.backgroundColor = .white
        
        navigationItem.title = "Search"
        
        tableView.rowHeight = 88
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: identifier)
    }
    
    func setupSearchController(){
        
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.placeholder = "Search Movie.."
        
        self.searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.searchBar.tintColor = .black
    }
}

//MARK: - UISearchControllerDelegate

extension SearchViewController : UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard var text = searchController.searchBar.text else {return}
        
        searchMovies(text: text)
    }
}

extension SearchViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = nil
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! SearchCell
        cell.viewModel = HomeViewModel(movie: movies[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        let controller = DetailViewController(collectionViewLayout: layout)
        controller.movie = movies[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
