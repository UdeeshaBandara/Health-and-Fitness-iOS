//
//  ExerciseTrackCell.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-18.
//

import Foundation
import UIKit
import SnapKit
import SwiftyJSON

class ExerciseTrackCell : UITableViewCell {
    
    var onCompleteClick: (() -> Void)? = nil
    
    let mainView : UIView = {
        
        let outerView = UIView()
        outerView.clipsToBounds = false
        outerView.layer.cornerRadius = 20
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
    let vStackMain : UIStackView = {
        
        let stackView = UIStackView()
        
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing  = 10
        stackView.axis = .vertical
        return stackView
        
    }()
    let hStack : UIStackView = {
        
        let stackView = UIStackView()
        
        stackView.alignment = .center
        stackView.distribution = .fill
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
        lbl.font = UIFont(name: "Roboto-MediumItalic", size: 14)
        lbl.textAlignment = .left
        lbl.textColor = .black
        
        return lbl
    }()
        
    let repSetCount: UILabel = {
        let lbl = UILabel()
        lbl.text = "10 Reps X 3 Sets"
        lbl.font = UIFont(name: "Roboto-MediumItalic", size: 14)
        lbl.textAlignment = .left
        lbl.textColor = #colorLiteral(red: 0.9386845231, green: 0.352627635, blue: 0.1541865468, alpha: 1)
        
        return lbl
    }()
    let timeConsumption: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-MediumItalic", size: 14)
        lbl.textAlignment = .left
        lbl.textColor = .black 
        lbl.numberOfLines = 2
        lbl.isHidden = true
        return lbl
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
    let markAsCompleteButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Mark as completed", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 12)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
      
        
        return button
        
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        
        vStack.addArrangedSubview(exerciseName)
        vStack.addArrangedSubview(repSetCount)
        vStack.addArrangedSubview(timeConsumption)
        
        subView.addSubview(exerciseImage)
        subView.addSubview(outerShade)
        
        hStack.addArrangedSubview(subView)
        hStack.addArrangedSubview(vStack)

        vStackMain.addArrangedSubview(hStack)
        vStackMain.addArrangedSubview(markAsCompleteButton)
        
        mainView.addSubview(vStackMain)
        contentView.addSubview(mainView)
        
        setupConstraint()
        
        markAsCompleteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onComplete(sender:))))
        
        
    }
    
    func setupConstraint(){
        mainView.snp.makeConstraints { const in
 
            const.height.equalTo(160)
            const.width.equalTo(contentView).inset(20)
            const.centerX.equalTo(contentView)
        }
        subView.snp.makeConstraints { const in

            const.height.width.equalTo(90)
            const.top.equalTo(mainView).offset(10)
            const.leading.equalTo(mainView).inset(10)

        }
        exerciseImage.snp.makeConstraints { const in

            const.edges.equalTo(subView)
        }
        
        outerShade.snp.makeConstraints { const in

            const.edges.equalTo(subView)

        }
        
        vStackMain.snp.makeConstraints { const in
            
            const.width.equalTo(mainView).inset(10)
            const.centerY.equalTo(mainView)

           
        }
        markAsCompleteButton.snp.makeConstraints { const in
             
            const.width.equalTo(vStackMain)
           
        }
        
    }
    @objc func onComplete(sender : UIButton){
        onCompleteClick?()
        
    }
}


