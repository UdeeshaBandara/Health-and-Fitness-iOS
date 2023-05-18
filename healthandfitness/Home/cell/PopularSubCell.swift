//
//  PopularSubCell.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-08.
//

import Foundation
import UIKit
import SnapKit


class PopularSubCell : UICollectionViewCell {
    
    let backgroundImage : UIImageView = {
        let imgView =   UIImageView(image: #imageLiteral(resourceName: "popular_image"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 15
        return imgView
    }()
    let outerView : UIView = {
        
        let outerView = UIView()
        outerView.clipsToBounds = false
        outerView.layer.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        outerView.clipsToBounds = true
        outerView.layer.cornerRadius = 15
        return outerView
        
    }()
    
    let title : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.numberOfLines = 2
        lbl.sizeToFit()
        lbl.text = "Hand Training"
        lbl.font = lbl.font.withSize(20)
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    
    let vStack : UIStackView = {
        
        let stackView = UIStackView()
        
        stackView.alignment = .leading
        stackView.spacing  = 10
        stackView.axis = .vertical
        return stackView
        
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
         
        contentView.addSubview(backgroundImage)
        contentView.addSubview(outerView)
        vStack.addArrangedSubview(title) 
        
        contentView.addSubview(vStack)
        setupConstraint()
        
    }
    
    func setupConstraint(){
        
        backgroundImage.snp.makeConstraints { const in
            
            const.edges.equalTo(contentView)
            
        }
        outerView.snp.makeConstraints { const in
            
            const.edges.equalTo(contentView)
            
        }
        
        vStack.snp.makeConstraints { const in
            
            const.leading.equalTo(contentView.snp.leading).offset(10)
            const.trailing.equalTo(contentView.snp.trailing).offset(-10)
            const.centerY.equalTo(contentView.snp.centerY)
            
        }
    }
}
