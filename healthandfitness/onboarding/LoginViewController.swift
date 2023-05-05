//
//  LoginViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-05.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    let scrollView = UIScrollView()
    
    let email  = UITextField()
    let password  = UITextField()
    
    let signInLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = "Sign In"
        lbl.font = UIFont(name:"Roboto-Light",size:100)
        lbl.font = lbl.font.withSize(25)
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
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        
        return button
        
    }()
    
    
    let register : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = "Don't have an account? Sign Up"
        lbl.font = UIFont(name:"Roboto-Light",size:100)
        lbl.font = lbl.font.withSize(14)
        lbl.textAlignment = .center
       
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(scrollView)
      

        view.addSubview(signInLabel)
        view.addSubview(register)
        vStack.addArrangedSubview(email)
        vStack.addArrangedSubview(password)
        vStack.addArrangedSubview(submitButton)
        scrollView.addSubview(vStack)
        setupConstraint()
       
    }
    func setupConstraint(){
        
        
        email.updateDesign()
        email.placeholder = "Email address"
        password.placeholder = "Password"
        password.updateDesign()
        
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
            
            
            const.centerY.equalTo(view.snp.centerY).offset(-130)
            const.centerX.equalTo(view.snp.centerX)
            
        }
        
        password.snp.makeConstraints { const in
            
            const.height.equalTo(45)
            
        }
        submitButton.snp.makeConstraints { const in
            
            const.height.equalTo(45)
        }
        
        register.snp.makeConstraints { const in
            
            const.height.equalTo(45)
            const.centerX.equalTo(view.snp.centerX)
            const.bottom.equalTo(view.snp.bottom).offset(-20)
        }
        
        
    }

}
