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

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    let scrollView = UIScrollView()
    
    let name  = UITextField()
    let email  = UITextField()
    let password  = UITextField()
    let phone  = UITextField()
    
    let signUpLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = "Sign Up"
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
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        
        return button
        
    }()
    
    
    let loginLabel : UILabel = {
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
        
        
        view.addSubview(signUpLabel)
        view.addSubview(loginLabel)
        vStack.addArrangedSubview(name)
        vStack.addArrangedSubview(email)
        vStack.addArrangedSubview(phone)
        vStack.addArrangedSubview(password)
        vStack.addArrangedSubview(submitButton)
        scrollView.addSubview(vStack)
        setupConstraint()
        
        loginLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLogin(sender:))))
        
        submitButton.addTarget(self, action: #selector(performRegistration), for: .touchUpInside)
        
        
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
        phone.delegate = self
        phone.keyboardType = .numberPad
        
        email.attributedPlaceholder = NSAttributedString(string: "Email address", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        name.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        phone.attributedPlaceholder = NSAttributedString(string: "Phone", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        password.isSecureTextEntry = true
        
        signUpLabel.snp.makeConstraints { const in
            
            
            const.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            const.centerX.equalTo(view.snp.centerX)
            
        }
        
        scrollView.snp.makeConstraints { const in
            const.center.equalTo(view)
            const.width.equalTo(view.snp.width).inset(20)
            const.top.equalTo(signUpLabel.snp.bottom)
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
        name.snp.makeConstraints { const in
            
            const.height.equalTo(45)
        }
        phone.snp.makeConstraints { const in
            
            const.height.equalTo(45)
        }
        
        loginLabel.snp.makeConstraints { const in
            
            const.height.equalTo(45)
            const.centerX.equalTo(view.snp.centerX)
            const.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        
        
    }
    @objc func performRegistration(sender : UIButton){
        
        registrationNetworkRequest()
        
       
        
    }
    @objc func openLogin(sender : UIButton){
        
       
        navigationController?.popViewController(animated: false)
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
    
        
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    func registrationNetworkRequest () {
       
           let param = [
               "email" : email.text!,
               "telephone" : phone.text!,
               "name" : name.text!,
               "password" : password.text!
           ]
           
        NetworkManager.shared.defaultNetworkRequest(url: HealthAndFitnessBase.BaseURL + "auth/register", param: param, requestMethod: .post, showIndicator: true, indicatorParent: self.view, encoder: JSONEncoding.default, success: { response in
               print(response)
               if response["status"].boolValue {
                   
                   HealthAndFitnessBase.shared.showToastMessage(title: "Registration", message: "Registration successful", type: 0)
                   self.navigationController?.popViewController(animated: false)
                   
               }else{
                   
                   HealthAndFitnessBase.shared.showToastMessage(title: "Registration", message: response["data"].stringValue)
                   
               }
               
              

           }){errorString in
               
             
               HealthAndFitnessBase.shared.showToastMessage(title: "Registration", message: "Something went wrong. Please try again")
               
           }
           
           
       }
}

