//
//  LoginViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-05.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

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
        lbl.font = UIFont(name:"Roboto-Bold",size:30)
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
        lbl.isUserInteractionEnabled = true
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
        
        register.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openRegistration(sender:))))
        
        submitButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openWizard(sender:))))
        
    }
    func setupConstraint(){
        
        
        email.updateDesign()
        password.updateDesign()
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        email.attributedPlaceholder = NSAttributedString(string: "Email address", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        password.isSecureTextEntry = true
        
        signInLabel.snp.makeConstraints { const in
            
            
            const.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            const.centerX.equalTo(view.snp.centerX)
            
        }
        
        
        scrollView.snp.makeConstraints { const in
            const.center.equalTo(view)
            const.width.equalTo(view.snp.width).inset(20)
            const.top.equalTo(signInLabel.snp.bottom)
        }
        
        
        
        vStack.snp.makeConstraints { const in
            
            
            const.centerY.equalTo(scrollView.snp.centerY)
            const.width.equalTo(scrollView.snp.width)
            
        }
        
        
        email.snp.makeConstraints { const in
            
            const.height.equalTo(45)
            
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
    @objc func openRegistration(sender : UIButton){
        
        navigationController?.pushViewController(RegisterViewController(), animated: false)
        
    }
    @objc func openWizard(sender : UIButton){
        
        loginNetworkRequest()
        
       
        
    }
    
    func loginNetworkRequest () {
       
           let param = [
               "email" : email.text!,
               "password" : password.text!
           ]
           
        NetworkManager.shared.defaultNetworkRequest(url: HealthAndFitnessBase.BaseURL + "auth/login", param: param, requestMethod: .post, showIndicator: true, indicatorParent: self.view, encoder: JSONEncoding.default, success: { response in
               
              
               if response["status"].boolValue {
                   
                   
                   HealthAndFitnessBase.shared.showToastMessage(title: "Login", message: "Login successful", type: 0)
                   KeychainWrapper.standard.set( response["accessToken"].stringValue, forKey: "accessToken")
                   KeychainWrapper.standard.set( true, forKey: "isLoggedIn")
                   KeychainWrapper.standard.set( false, forKey: "isWizardCompleted")
                   let layout = UICollectionViewFlowLayout()
                   layout.scrollDirection = .horizontal
                 
                   self.navigationController?.pushViewController(WizardController(collectionViewLayout: layout), animated: false)
                   
               }else{
                   
                   HealthAndFitnessBase.shared.showToastMessage(title: "Login", message: response["data"].stringValue)
                   
               }
               
              

           }){errorString in
               
             
               HealthAndFitnessBase.shared.showToastMessage(title: "Login", message: "Something went wrong. Please try again")
               
           }
           
           
       }
       
}
