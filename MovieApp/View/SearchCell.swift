//
//  SearchCell.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import UIKit

class SearchCell : UITableViewCell {
    
    
    //MARK: - Properties
    
    var viewModel : HomeViewModel? {
        didSet{configure()}
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
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    //MARK: - Lifecycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        addSubview(movieImage)
        movieImage.centerY(inView: self,leftAnchor: leftAnchor)
        movieImage.setDimensions(height: 80, width: 120)
        
        addSubview(imageLabel)
        imageLabel.centerY(inView: movieImage,leftAnchor: movieImage.rightAnchor,paddingLeft: 12)
    }
    
    func configure(){
        guard let viewModel = viewModel else {return}
        
        movieImage.sd_setImage(with: viewModel.movieImage)
        
        imageLabel.text = viewModel.movieName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

