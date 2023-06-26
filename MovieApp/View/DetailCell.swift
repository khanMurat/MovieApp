//
//  DetailCell.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import UIKit
import SDWebImage

protocol DetailCellDelegate : AnyObject {
    func didLike(_ cell : DetailCell,movie:Movie)
}

class DetailCell : UICollectionViewCell {
    
    //MARK: - Properties
    weak var delegate : DetailCellDelegate?
    
    var viewModel : DetailViewModel? {
        didSet{configureUI()}
    }
    
     lazy var likeButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "heart"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return btn
    }()
    
    private let movieImage : UIImageView = {
       
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "film")
       iv.clipsToBounds = true
        return iv
    }()
    
    private let releaseLabel : UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let totalLabel : UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let voteLabel : UILabel = {
       let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let overViewLabel : UILabel = {
       let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
  
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        addSubview(movieImage)
        movieImage.anchor(top: safeAreaLayoutGuide.topAnchor,left: leftAnchor,paddingTop: 12)
        movieImage.setDimensions(height: 250, width: 250)
        
        let stack = UIStackView(arrangedSubviews: [releaseLabel,totalLabel,voteLabel,likeButton])
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fillEqually
        stack.alignment = .leading
        
        addSubview(stack)
        stack.anchor(top: safeAreaLayoutGuide.topAnchor,left: movieImage.rightAnchor,right: rightAnchor,paddingTop: 12,paddingRight: 24)
        
        addSubview(overViewLabel)
        overViewLabel.anchor(top: stack.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 12,paddingLeft: 8,paddingRight: 8)
        
    }
    
    //MARK: - Action
    
    @objc func handleLike(){
       
        guard let viewModel = viewModel else {return}
        delegate?.didLike(self, movie: viewModel.movie)
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        
        guard let viewModel = viewModel else {return}
        
        movieImage.sd_setImage(with: viewModel.movieImage)
        
        releaseLabel.attributedText = attributedTitle(firstPart: "RELEASE DATE", secondPart: viewModel.releaseDate)
        totalLabel.attributedText = attributedTitle(firstPart: "TOTAL VIEW", secondPart: "\(viewModel.totalView)")
        voteLabel.attributedText = attributedTitle(firstPart: "VOTE RATE", secondPart: "\(viewModel.voteAverage)")
        overViewLabel.attributedText = attributedTitle(firstPart: "OVERVIEW", secondPart: "\(viewModel.overView)")
        
        likeButton.setImage(viewModel.buttonImg, for: .normal)
        
        likeButton.tintColor = viewModel.buttonColor
        
        print(viewModel.didLike)
        
    }
    
    func attributedTitle(firstPart: String, secondPart: String) -> NSAttributedString {
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: 18)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart)\n", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: 14)]
        attributedTitle.append(NSAttributedString(string: "\(secondPart)", attributes: boldAtts))
        
        return attributedTitle
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

