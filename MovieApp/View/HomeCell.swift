//
//  HomeCell.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import UIKit
import SDWebImage


class HomeCell : UICollectionViewCell {
    
    //MARK: - Properties
    
    var viewModel : HomeViewModel? {
        didSet{configureUI()}
    }
    
    private let movieImage : UIImageView = {
       
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "film")
        iv.clipsToBounds = true
        return iv
    }()
    
    private let imageLabel : UILabel = {
       
        let label = UILabel()
        label.text = "Movie"
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        addSubview(movieImage)
        movieImage.anchor(top: safeAreaLayoutGuide.topAnchor,left: leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingBottom: 32)
        
        addSubview(imageLabel)
        imageLabel.anchor(top: movieImage.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 2)
        
        
    }
    
    
    //MARK: - Helpers
    
    func configureUI(){
        
        guard let viewModel = viewModel else {return}
        
        movieImage.sd_setImage(with: viewModel.movieImage)
        
        imageLabel.text = viewModel.movieName
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
