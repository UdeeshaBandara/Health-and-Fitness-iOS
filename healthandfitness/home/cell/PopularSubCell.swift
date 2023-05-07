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
//        outerView.layer.backgroundColor =  #colorLiteral(red: 0.7927033305, green: 0.7747715712, blue: 0.7945697904, alpha: 0.4)
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
    let duration : PaddingLabel = {
        let lbl = PaddingLabel(withInsets: 5,5,8,8)
        lbl.textColor = .black
        lbl.numberOfLines = 2
        lbl.sizeToFit()
        lbl.font = lbl.font.withSize(14)
        lbl.textAlignment = .left
        lbl.layer.cornerRadius = 5
        lbl.clipsToBounds = true
        lbl.backgroundColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)
        return lbl
    }()
    let cal : PaddingLabel = {
        let lbl = PaddingLabel(withInsets: 5,5,8,8)
        lbl.textColor = .black
        lbl.numberOfLines = 2
        lbl.sizeToFit()
        lbl.font = lbl.font.withSize(14)
        lbl.textAlignment = .left
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 5
        lbl.backgroundColor =   #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)
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
        
        
        
        cal.text = " 600 Kcal"
        duration.text = " 40 Min"
        cal.addImage(imageName: "cal")
        duration.addImage(imageName: "timer")
        
        outerView.applyGradient(isVertical: false, colorArray: [.green, .blue])
        contentView.addSubview(backgroundImage)
        contentView.addSubview(outerView)
        vStack.addArrangedSubview(title)
        vStack.addArrangedSubview(cal)
        vStack.addArrangedSubview(duration)
        
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
