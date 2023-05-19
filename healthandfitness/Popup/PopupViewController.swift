//
//  LogoutViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-17.
//

import UIKit
import SnapKit
import SwiftKeychainWrapper

protocol LogoutViewControllerDelegate: AnyObject {
    func onLogout()
    func onClearLogs()
}

class PopupViewController: UIViewController {

    weak var delegate: LogoutViewControllerDelegate?
    
    var type : Int = 1
    
    var messageText : String = ""
    
    let logoutMessage: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Medium", size: 18)
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.textColor = .black
      
        return lbl
    }()
    
    let popupBox: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
        
    }()
    
    let hStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing  = 10
        stackView.axis = .horizontal
        return stackView
        
    }()
    
    let confirmButton  : UIButton = {
        
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        
        return button
        
    }()
    let cancelButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .white
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5

        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        view.addSubview(popupBox)
        view.addSubview(logoutMessage)
        hStack.addArrangedSubview(cancelButton)
        hStack.addArrangedSubview(confirmButton)
        view.addSubview(hStack)
        
        logoutMessage.text = messageText
        
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)
        
        popupBox.snp.makeConstraints { const in
            
            const.height.equalTo(250)
            const.center.equalTo(view)
            const.width.equalTo(((UIScreen.main.bounds.width/5)*4))
        }
            
            
        logoutMessage.snp.makeConstraints { const in
            
       
            const.top.equalTo(popupBox).inset(75)
            const.width.equalTo(popupBox).inset(10)
            const.centerX.equalTo(view)
            
            
        }
        hStack.snp.makeConstraints { const in
            
       
            const.centerY.equalTo(view).offset(50)
            const.centerX.equalTo(view)
            const.width.equalTo(popupBox).inset(10)
            const.height.equalTo(45)
            
            
        }
        
    }
    @objc private func handleCancel() {
        
        self.dismiss(animated: true,completion: nil)
        
    }
    
    @objc private func handleConfirm() {

        self.dismiss(animated: true,completion: {
            if(self.type == 1){
                self.delegate?.onLogout()
            }else if(self.type == 2){
                self.delegate?.onClearLogs()
            }
        })
    }
   
}
