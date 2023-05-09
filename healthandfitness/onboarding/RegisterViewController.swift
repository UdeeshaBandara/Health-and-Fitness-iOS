//
//  LoginViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-05.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let name  = UITextField()
    let email  = UITextField()
    let password  = UITextField()
    let phone  = UITextField()
    
    let signInLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = "Sign Up"
        lbl.font = UIFont(name:"Roboto-MediumItalic",size:30)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    let vStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing  = 30
        stackView.axis = .vertical
        return stackView
        
    }()
    
    
    let submitButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-MediumItalic", size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        
        return button
        
    }()
    
    
    let register : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = "Already have an account? Sign in"
        lbl.font = UIFont(name:"Roboto-Light",size:100)
        lbl.font = lbl.font.withSize(14)
        lbl.textAlignment = .center
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        
        view.addSubview(signInLabel)
        view.addSubview(register)
        vStack.addArrangedSubview(name)
        vStack.addArrangedSubview(email)
        vStack.addArrangedSubview(phone)
        vStack.addArrangedSubview(password)
        vStack.addArrangedSubview(submitButton)
        scrollView.addSubview(vStack)
        setupConstraint()
        
        register.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openRegistration(sender:))))
        
    }
    func setupConstraint(){
        
        
        email.updateDesign()
        password.updateDesign()
        name.updateDesign()
        phone.updateDesign()
        email.placeholder = "Email address"
        password.placeholder = "Password"
        name.placeholder = "Full Name"
        phone.placeholder = "Phone"
        email.attributedPlaceholder = NSAttributedString(string: "Email address", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        name.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        phone.attributedPlaceholder = NSAttributedString(string: "Phone", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        password.isSecureTextEntry = true
        
        
        scrollView.snp.makeConstraints { const in
            const.centerX.equalTo(view.snp.centerX)
            const.centerY.equalTo(view.snp.centerY).offset(-80)
            const.width.equalTo(view.snp.width).inset(20)
            const.top.equalTo(view.snp.top)
        }
        
        vStack.snp.makeConstraints { const in
            
            
            const.centerY.equalTo(scrollView.snp.centerY)
            const.width.equalTo(scrollView.snp.width)
            
        }
        
        
        email.snp.makeConstraints { const in
            
            const.height.equalTo(45)
            
        }
        signInLabel.snp.makeConstraints { const in
            
            
            const.centerY.equalTo(view.snp.centerY).offset(-200)
            const.centerX.equalTo(view.snp.centerX)
            
        }
        
        password.snp.makeConstraints { const in
            
            const.height.equalTo(45)
            
        }
        submitButton.snp.makeConstraints { const in
            
            const.height.equalTo(45)
        }
        name.snp.makeConstraints { const in
            
            const.height.equalTo(45)
        }
        phone.snp.makeConstraints { const in
            
            const.height.equalTo(45)
        }
        
        register.snp.makeConstraints { const in
            
            const.height.equalTo(45)
            const.centerX.equalTo(view.snp.centerX)
            const.bottom.equalTo(view.snp.bottom).offset(-20)
        }
        
        
    }
    @objc func openRegistration(sender : UIButton){
        
        navigationController?.popViewController(animated: true)
        
        
    }
}
