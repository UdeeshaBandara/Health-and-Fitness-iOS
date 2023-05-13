//
//  ExerciseSelectCell.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-12.
//

import Foundation
import UIKit

class ExerciseSelectCell: UITableViewCell {

    
    var onSelectExercise: ((_ isSelected : Bool) -> Void)? = nil
    
    let repCount  = UITextField()
    let setCount  = UITextField()
    
    let exerciseImage : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "male"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
  
    let exerciseLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Regular", size: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 3
        lbl.textColor = .black 
        return lbl
    }()
     
    let vStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    
    let hStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
        

    let hStackRepSet : UIStackView = {
        
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 15
        return stackView
    }()
    
    let selectionSwitch : UISwitch = {
        
        let uISwitch = UISwitch()
        uISwitch.isOn = false
        uISwitch.onTintColor = .black
        return uISwitch
    }()
    
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.superview?.backgroundColor = .white
        accessoryView = selectionSwitch
        accessoryView?.backgroundColor = .white 
        setupConstraint()
        
        selectionSwitch.addTarget(self, action: #selector(changeSelection), for: .valueChanged)
        
    }
    
    private func setupConstraint() {
        
        
     
        setCount.updateDesign()
        setCount.keyboardType = .numberPad
        setCount.attributedPlaceholder = NSAttributedString(string: "No of sets", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        repCount.updateDesign()
        repCount.keyboardType = .numberPad
        repCount.attributedPlaceholder = NSAttributedString(string: "No of reps", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])

        
        hStack.addArrangedSubview(exerciseImage)
        hStack.addArrangedSubview(exerciseLabel)
        hStackRepSet.addArrangedSubview(setCount)
        hStackRepSet.addArrangedSubview(repCount)
        
        vStack.addArrangedSubview(hStack)
        vStack.addArrangedSubview(hStackRepSet)
        
        contentView.addSubview(vStack)
   
        vStack.snp.makeConstraints { const in
            
            const.edges.equalTo(contentView)

        }
        hStack.snp.makeConstraints { const in
            
            const.leading.trailing.equalTo(contentView)

        }
             
        hStackRepSet.snp.makeConstraints { const in
            
            const.leading.trailing.equalTo(contentView)

        }
          
        exerciseImage.snp.makeConstraints { const in
            
            const.height.width.equalTo(100)
        }
                  
        setCount.snp.makeConstraints { const in
            
            const.height.equalTo(45)
        }
        
         
        repCount.snp.makeConstraints { const in
            
            const.height.equalTo(45)
        }
        
         
        
    }
    
    @objc func changeSelection(sender : UIButton){
        
        onSelectExercise?(selectionSwitch.isOn)
        
        
        
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
