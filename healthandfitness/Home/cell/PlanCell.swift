//
//  PlanCell.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-07.
//


import Foundation
import UIKit
import SnapKit

class PlanCell : UITableViewCell {
    
    let popluarCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    


    let mainView : UIView = {
        
        let outerView = UIView()
        outerView.clipsToBounds = false
        outerView.layer.cornerRadius = 20
        outerView.backgroundColor =   #colorLiteral(red: 0.9695064425, green: 0.9645406604, blue: 0.9818398356, alpha: 1)
 
        return outerView
        
    }()
    
    let vStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing  = 10
        stackView.axis = .vertical
 
        return stackView
        
    }()
    let hStack : UIStackView = {
        
        let stackView = UIStackView()
        
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing  = 10
        stackView.axis = .horizontal
      
        return stackView
        
    }()
    
    let exerciseImage : UIImageView = {
        let imgView =   UIImageView(image: #imageLiteral(resourceName: "popular_image"))
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 20
 
        return imgView
    }()
    
    let exerciseName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Bold", size: 14)
        lbl.textAlignment = .left
        lbl.textColor = .black
      
        return lbl
    }()
        
    let progressValue: UILabel = {
        let lbl = UILabel()
        lbl.text = "Progress"
        lbl.font = UIFont(name: "Roboto-Thin", size: 10)
        lbl.textAlignment = .left
        lbl.textColor = .black
        return lbl
    }()
    
    let progressView: UIProgressView = {
        
        let progressView = UIProgressView(progressViewStyle: .bar)
        
        progressView.setProgress(28/100, animated: true)
        progressView.trackTintColor = #colorLiteral(red: 0.9386845231, green: 0.352627635, blue: 0.1541865468, alpha: 0.5)
        progressView.tintColor =  #colorLiteral(red: 0.9386845231, green: 0.352627635, blue: 0.1541865468, alpha: 0.8871326573)
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        return progressView
    }()
    
    let outerShade : UIView = {
        
        let outerView = UIView()
        outerView.clipsToBounds = false
        outerView.layer.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        outerView.clipsToBounds = true
        outerView.layer.cornerRadius = 20
        return outerView
        
    }()
    let subView : UIView = {
        
        let outerView = UIView()
        outerView.clipsToBounds = false
        outerView.layer.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        outerView.clipsToBounds = true
        outerView.layer.cornerRadius = 20
        return outerView
        
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        contentView.isUserInteractionEnabled = true
        
        vStack.addArrangedSubview(exerciseName)
        vStack.addArrangedSubview(progressValue)
        vStack.addArrangedSubview(progressView)
        
        subView.addSubview(exerciseImage)
        subView.addSubview(outerShade)
         
        hStack.addArrangedSubview(subView)
        hStack.addArrangedSubview(vStack)

        mainView.addSubview(hStack)
        contentView.addSubview(mainView)
        
        
        setupConstraint()
        
    }
    
    func setupConstraint(){
        mainView.snp.makeConstraints { const in 
 
            const.height.equalTo(110)
            const.width.equalTo(contentView).inset(20)
            const.centerX.equalTo(contentView)
        }
        subView.snp.makeConstraints { const in

            const.height.width.equalTo(90)
            const.centerY.equalTo(mainView)
            const.leading.equalTo(mainView).inset(10)

        }
        exerciseImage.snp.makeConstraints { const in

            const.edges.equalTo(subView)
            
        }
        
        outerShade.snp.makeConstraints { const in

            const.edges.equalTo(subView)

        }
        
        hStack.snp.makeConstraints { const in
            
            const.width.equalTo(mainView)
            const.centerY.equalTo(mainView)

           
        }
        vStack.snp.makeConstraints { const in
            
            const.centerY.equalTo(mainView)
           
        }
        progressView.snp.makeConstraints { const in
            
            const.width.equalTo(vStack).inset(10)
            const.height.equalTo(15)
           
        }
       
    } 
}

