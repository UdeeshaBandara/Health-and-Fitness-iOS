//
//  GoalCell.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-14.
//

import Foundation
import UIKit

class GoalCell : UITableViewCell{
    
    
    let mainView : UIView = {
        
        let outerView = UIView()
        outerView.clipsToBounds = false
        outerView.layer.cornerRadius = 20
        outerView.backgroundColor =  .white
        outerView.layer.borderWidth =  1
        outerView.layer.borderColor =   #colorLiteral(red: 0.8944590688, green: 0.9143784642, blue: 0.9355253577, alpha: 1)
 
        return outerView
        
    }()
    let hStack : UIStackView = {
        
        let stackView = UIStackView()
        
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing  = 10
        stackView.axis = .horizontal
      
        return stackView
        
    }()
    
    let goalImage : UIImageView = {
        let imgView =   UIImageView(image: #imageLiteral(resourceName: "popular_image"))
        imgView.contentMode = .scaleAspectFit
 
        return imgView
    }()
    
    let goalName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Medium", size: 18)
        lbl.textAlignment = .left
        lbl.textColor = .black
      
        return lbl
    }()
        
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        hStack.addArrangedSubview(goalImage)
        hStack.addArrangedSubview(goalName)
       
        mainView.addSubview(hStack)
         
        contentView.addSubview(mainView)
        
        
        setupConstraint()
        
    }
    
    func setupConstraint(){
        mainView.snp.makeConstraints { const in
            
            const.edges.equalTo(contentView).inset(10)
            
        }
        hStack.snp.makeConstraints { const in
            
            const.edges.equalTo(mainView).inset(10)
            
        }
        goalImage.snp.makeConstraints { const in

            const.width.equalTo(40)
            const.centerY.equalTo(mainView)

        }
       
    }
}
