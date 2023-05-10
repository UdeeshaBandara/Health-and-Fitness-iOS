//
//  GenderCell.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-09.
//

import Foundation
import UIKit
import SnapKit

class GenderCell: UICollectionViewCell, UITextFieldDelegate {
    
    
    let title: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Bold", size: 24)
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.text = "Select Your Gender"
        return lbl
    }()
    
    let maleImage : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "male"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let femaleImage : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "female"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let maleLablel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Regular", size: 20)
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.text = "Male"
        return lbl
    }()
    
    let femaleLablel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Regular", size: 20)
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.text = "Female"
        return lbl
    }()
    
    let hStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    let vStackMale : UIStackView = {
        
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor =   #colorLiteral(red: 0.9695064425, green: 0.9645406604, blue: 0.9818398356, alpha: 1)
        stackView.layer.borderColor =   #colorLiteral(red: 0.9215685725, green: 0.9215685725, blue: 0.9215685725, alpha: 1)
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 10
        stackView.isUserInteractionEnabled = true
        return stackView
        
    }()
    let vStackFemale : UIStackView = {
        
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor =   #colorLiteral(red: 0.9695064425, green: 0.9645406604, blue: 0.9818398356, alpha: 1)
        stackView.layer.borderColor =   #colorLiteral(red: 0.9215685725, green: 0.9215685725, blue: 0.9215685725, alpha: 1)
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 10
        stackView.isUserInteractionEnabled = true
        return stackView
        
    }()
    
    
    let preferNotButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Prefer not to say", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraint()
        vStackMale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectMale(sender:))))
        vStackFemale.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectFemale(sender:))))
    }
    
    private func setupConstraint() {
        
        
        
        vStackMale.addArrangedSubview(maleImage)
        vStackMale.addArrangedSubview(maleLablel)
        
        vStackFemale.addArrangedSubview(femaleImage)
        vStackFemale.addArrangedSubview(femaleLablel)
        
        hStack.addArrangedSubview(vStackMale)
        hStack.addArrangedSubview(vStackFemale)
        contentView.addSubview(title)
        contentView.addSubview(hStack)
        contentView.addSubview(preferNotButton)
        
        
        vStackMale.snp.makeConstraints { const in
            
            const.height.equalTo(150)
        }
        
        vStackFemale.snp.makeConstraints { const in
            
            const.height.equalTo(150)
        }
        
        title.snp.makeConstraints { const in
            
            const.top.equalTo(contentView).inset(20)
            const.width.equalTo(contentView).inset(20)
            const.centerX.equalTo(contentView)
        }
        
        maleImage.snp.makeConstraints { const in
            
            const.width.equalTo(50)
            
        }
        femaleImage.snp.makeConstraints { const in
            
            const.width.equalTo(50)
            
        }
        hStack.snp.makeConstraints { const in
            
            const.width.equalTo(contentView).inset(20)
            const.centerX.equalTo(contentView)
            const.top.equalTo(title.snp.bottom).offset(20)
            
        }
        
    }
    
    @objc private func selectMale(sender : UITapGestureRecognizer) {
        
     
        vStackMale.layer.borderColor =   #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        vStackMale.layer.borderWidth = 2
        maleLablel .font = UIFont(name: "Roboto-Bold", size: 22)
        femaleLablel.font = UIFont(name: "Roboto-Regular", size: 20)
        
        vStackFemale.layer.borderColor =   #colorLiteral(red: 0.9215685725, green: 0.9215685725, blue: 0.9215685725, alpha: 1)
        vStackFemale.layer.borderWidth = 1
        
        
    }
    @objc private func selectFemale(sender : UITapGestureRecognizer) {
        
     
        vStackFemale.layer.borderColor =   #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        vStackFemale.layer.borderWidth = 2
        femaleLablel .font = UIFont(name: "Roboto-Bold", size: 22)
        maleLablel.font = UIFont(name: "Roboto-Regular", size: 20)
        
        vStackMale.layer.borderColor =   #colorLiteral(red: 0.9215685725, green: 0.9215685725, blue: 0.9215685725, alpha: 1)
        vStackMale.layer.borderWidth = 1
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        
        return string.rangeOfCharacter(from: invalidCharacters) == nil && newLength <= 3
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
