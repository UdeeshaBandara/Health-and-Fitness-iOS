//
//  PageCell.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-07.
//

import Foundation
import UIKit
import SnapKit
import LKRulerPicker

protocol WizardCellDelegate: AnyObject {
    func onTextChange(currentIndex: Int, value enteredValue : String)
}


class WizardCell: UICollectionViewCell, UITextFieldDelegate {
    
    
    var row : Int = -1
    
    weak var delegate: WizardCellDelegate?
    
    let title: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Bold", size: 24)
        lbl.textAlignment = .center
        lbl.textColor = .black
        return lbl
    }()
    
    let inputField  : UITextField={
        let lbl = UITextField()
        lbl.font = UIFont.init(name: "Roboto-Regular", size: 24)
        lbl.textAlignment = .left
        lbl.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.layer.borderWidth = 1
        lbl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        lbl.layer.cornerRadius = 5
        lbl.textColor = #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)
        lbl.autocorrectionType = .yes
        lbl.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        return lbl
        
    }()
    
    let measurementUnit: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.init(name: "Roboto-Bold", size: 24)
        lbl.textColor = .black
        return lbl
    }()
    
    
    let hStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
        
    }()
    
    private lazy var heightPicker: LKRulerPicker = {
        $0.dataSource = self
        $0.delegate = self
        $0.tintColor = UIColor.black.withAlphaComponent(0.5)
        $0.highlightLineColor = .black
        $0.highlightTextColor = .black
        return $0
    }(LKRulerPicker())
    private lazy var weightPicker: LKRulerPicker = {
        $0.dataSource = self
        $0.delegate = self
        $0.tintColor = UIColor.black.withAlphaComponent(0.5)
        $0.highlightLineColor = .black
        $0.highlightTextColor = .black
        return $0
    }(LKRulerPicker())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.addSubview(title)
        contentView.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        
        title.snp.makeConstraints { const in
            
            const.width.equalTo(contentView.snp.width).inset(20)
            const.centerX.equalTo(contentView.snp.centerX)
            const.top.equalTo(contentView).inset(20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellContent(row: Int){
        if(row == 1){
            inputField.delegate = self
            inputField.keyboardType = .numberPad
            setupConstraint()
            inputField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }else if(row == 2){
            configureHeightPicker()
        }else if(row == 3){
            configureWeightPicker()
        }
    }
    
    
    private func setupConstraint() {
        
        
        hStack.addArrangedSubview(inputField)
        hStack.addArrangedSubview(measurementUnit)
        contentView.addSubview(hStack)
        
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
    
    @objc final private func textFieldDidChange(textField: UITextField) {
        
        self.delegate?.onTextChange(currentIndex: row, value: textField.text!)
    }
    

    private func configureHeightPicker() {
        
        contentView.addSubview(heightPicker)
        
        heightPicker.snp.makeConstraints { const in
            const.width.equalTo(130)
            const.centerX.equalTo(contentView).offset(30)
            const.height.equalTo(250)
            const.top.equalTo(title.snp.bottom).offset(50)
         
        }
        
        
        heightPicker.layoutIfNeeded()
        
        
        let heightMetrics = LKRulerPickerConfiguration.Metrics(
            minimumValue: 50,
            defaultValue: 150,
            maximumValue: 300,
            divisions: 5,
            fullLineSize: 38,
            midLineSize: 28,
            smallLineSize: 28)
        heightPicker.configuration = LKRulerPickerConfiguration(
            scrollDirection: .vertical,
            alignment: .start,
            metrics: heightMetrics,
            isHapticsEnabled: true)
        heightPicker.dataSource = self
        heightPicker.delegate = self
    }
    
    private func configureWeightPicker() {
        
        contentView.addSubview(weightPicker)
        weightPicker.snp.makeConstraints { const in
            const.width.equalTo(contentView).inset(20)
            const.centerX.equalTo(contentView)
            const.height.equalTo(100)
            const.top.equalTo(title.snp.bottom).offset(50)
         
        }
        
        
        weightPicker.layoutIfNeeded()
        let weightMetrics = LKRulerPickerConfiguration.Metrics(
            minimumValue: 0,
            defaultValue: 50,
            maximumValue: 250,
            divisions: 10,
            fullLineSize: 40,
            midLineSize: 32,
            smallLineSize: 22)
        weightPicker.configuration = LKRulerPickerConfiguration(scrollDirection: .horizontal, alignment: .end, metrics: weightMetrics)
        weightPicker.font = UIFont(name: "AmericanTypewriter-Bold", size: 12)!
        weightPicker.highlightFont = UIFont(name: "AmericanTypewriter-Bold", size: 18)!
        weightPicker.dataSource = self
        weightPicker.delegate = self
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
   
}
extension WizardCell: LKRulerPickerDelegate {
    func rulerPicker(_ picker: LKRulerPicker, didSelectItemAtIndex index: Int) {
        
        self.delegate?.onTextChange(currentIndex: row, value: ((rulerPicker(picker, highlightTitleForIndex: index)) ?? "0"))

      
    }
}

extension WizardCell: LKRulerPickerDataSource {
    func rulerPicker(_ picker: LKRulerPicker, titleForIndex index: Int) -> String? {
        guard index % picker.configuration.metrics.divisions == 0 else { return nil }
        switch picker {
        case heightPicker:
            return "\(picker.configuration.metrics.minimumValue + index) cm"
        case weightPicker:
            return "\(picker.configuration.metrics.minimumValue + index) Kg"
        default:
            fatalError("Handler picker")
        }
        
    }
    
    func rulerPicker(_ picker: LKRulerPicker, highlightTitleForIndex index: Int) -> String? {
        switch picker {
        case heightPicker:
            return "\(picker.configuration.metrics.minimumValue + index)"
        case weightPicker:
            return "\(picker.configuration.metrics.minimumValue + index)"
        default:
            fatalError("Handler picker")
        }
    }
}
