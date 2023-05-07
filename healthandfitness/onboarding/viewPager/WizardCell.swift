//
//  PageCell.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-07.
//

import Foundation
import UIKit
import SnapKit

class WizardCell: UICollectionViewCell, UITextFieldDelegate {
    

     let title: UILabel = {
        let lbl = UILabel()
         lbl.font = UIFont(name: "Roboto-MediumItalic", size: 30)
        lbl.textAlignment = .center
    
      
        return lbl
    }()
    
    let inputField  : UITextField={
        let lbl = UITextField()
        lbl.font = UIFont.init(name: "Roboto-MediumItalic", size: 30)
        lbl.textAlignment = .left
        lbl.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.borderWidth = 1
        lbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.layer.cornerRadius = 5
        lbl.textColor = #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)
        lbl.autocorrectionType = .yes
        lbl.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
         return lbl
         
    }()
    
     let measurementUnit: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
         lbl.font = UIFont.init(name: "Roboto-MediumItalic", size: 30)
      
        return lbl
    }()
    
    
    let hStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inputField.delegate = self
        inputField.keyboardType = .numberPad
        setupConstraint()
    }
    
    private func setupConstraint() {
     
    
 
        contentView.addSubview(title)

        hStack.addArrangedSubview(inputField)
        hStack.addArrangedSubview(measurementUnit)
        contentView.addSubview(hStack)
    
        title.snp.makeConstraints { const in
 
           const.width.equalTo(contentView.snp.width).inset(20)
            const.centerX.equalTo(contentView.snp.centerX)
            const.top.equalTo(contentView.snp.top).inset(100)
        }
     
        hStack.snp.makeConstraints { const in
            const.height.equalTo(45)
          
            const.centerX.equalTo(contentView.snp.centerX)
             const.top.equalTo(title.snp.bottom).offset(50)

        }
        inputField.snp.makeConstraints { const in
            const.width.equalTo(100)
            const.height.equalTo(45)
     

        }
        
     
       
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
