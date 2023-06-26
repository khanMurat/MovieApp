//
//  FavoriteCell.swift
//  MovieApp
//
//  Created by Murat on 23.06.2023.
//

import UIKit

protocol FavoriteCellDelegate : AnyObject {
    func didLike(_ cell : FavoriteCell,favorite:FavoriteMovie)
}

class FavoriteCell : UITableViewCell {
    
    
    //MARK: - Properties
    
    weak var delegate : FavoriteCellDelegate?
    
    var viewModel : FavoriteViewModel? {
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
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var likeButton : UIButton = {
       let btn = UIButton(type: .system)
       btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
       btn.tintColor = .red
       btn.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
       return btn
   }()
    
    //MARK: - Actions
    
    @objc func handleLikeButton(){
        
        guard let viewModel = viewModel else {return}
        delegate?.didLike(self, favorite: viewModel.favorites)
    }
    
    
    //MARK: - Lifecycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        selectionStyle = .none
        
        contentView.addSubview(movieImage)
        movieImage.centerY(inView: self,leftAnchor: leftAnchor,paddingLeft: 12)
        movieImage.setDimensions(height: 80, width: 80)
        
        contentView.addSubview(imageLabel)
        imageLabel.centerY(inView: movieImage,leftAnchor: movieImage.rightAnchor,paddingLeft: 8)
        imageLabel.anchor(right: rightAnchor,paddingRight: 24)
        
        contentView.addSubview(likeButton)
        likeButton.centerY(inView: self)
        likeButton.anchor(right: rightAnchor,paddingRight: 12)
    }
    
    func configure(){
        guard let viewModel = viewModel else {return}
        
        movieImage.sd_setImage(with: viewModel.image)
        
        imageLabel.text = viewModel.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


