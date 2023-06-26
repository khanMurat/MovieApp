//
//  ViewController.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import UIKit

class MainTabController: UITabBarController {

    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabbar()
    }

    
    //MARK: - Helpers
    
    func configureTabbar(){
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        
      let layout = UICollectionViewFlowLayout()
        
        let home = navController(rootVC: HomeViewController(collectionViewLayout: layout), unselectedImage: #imageLiteral(resourceName: "home_unselected"),selectedImage: #imageLiteral(resourceName: "home_selected"))
        
        let search = navController(rootVC: SearchViewController(), unselectedImage: #imageLiteral(resourceName: "search_unselected"),selectedImage: #imageLiteral(resourceName: "search_selected"))
        
        let categories = navController(rootVC: CategoriesViewController(), unselectedImage: #imageLiteral(resourceName: "list"),selectedImage: #imageLiteral(resourceName: "list"))
        
        let favorites = navController(rootVC: FavoritesViewController(), unselectedImage: #imageLiteral(resourceName: "like_unselected"),selectedImage: #imageLiteral(resourceName: "like_selected"))
        
        viewControllers = [home,search,categories,favorites]
        
    }
    
    private func navController(rootVC:UIViewController,unselectedImage:UIImage,selectedImage:UIImage)->UIViewController{
        
        let navController = UINavigationController(rootViewController: rootVC)
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.image = unselectedImage
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navController.navigationBar.tintColor = .white
        return navController
    }

}

