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
    
    
    let email  = UITextField()
    let password  = UITextField()
    
    let scrollView = UIScrollView()
    
    let signInLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = "Health & Fitness"
        lbl.font = UIFont(name:"Roboto-MediumItalic",size:30)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    let sloganLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = #colorLiteral(red: 0.9386845231, green: 0.352627635, blue: 0.1541865468, alpha: 1)
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = "Your personal fitness trainer"
        lbl.font = UIFont(name:"Roboto-Regular",size:18)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    let logo : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "icon"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let vStack : UIStackView = {
        
        let stackView = UIStackView()
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
        view.addSubview(logo)
        view.addSubview(signInLabel)
        view.addSubview(sloganLabel)
        view.addSubview(scrollView)
        vStack.addArrangedSubview(email)
        vStack.addArrangedSubview(password)
        vStack.addArrangedSubview(submitButton)
        scrollView.addSubview(vStack)
        view.addSubview(scrollView)
        view.addSubview(register)
        
        setupConstraint()
        
        register.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openRegistration(sender:))))
        
        submitButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openWizard(sender:))))
        
    }
    func setupConstraint(){
        
        
        email.updateDesign()
        password.updateDesign()
        email.keyboardType = .emailAddress
        password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        email.attributedPlaceholder = NSAttributedString(string: "Email address", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        password.isSecureTextEntry = true
        
        logo.snp.makeConstraints { const in
            
            
            const.top.equalTo(view.safeAreaLayoutGuide)
            const.leading.equalTo(view).inset(20)
            const.width.height.equalTo(140)
            
            
        }
        signInLabel.snp.makeConstraints { const in
            
            const.top.equalTo(logo.snp.bottom).offset(20)
            const.leading.equalTo(view).inset(20)
            
        }
        sloganLabel.snp.makeConstraints { const in
            
            
            const.top.equalTo(signInLabel.snp.bottom).offset(20)
            const.leading.equalTo(view).inset(20)
            
        }
       
 
        scrollView.snp.makeConstraints { const in
           
            const.width.equalTo(view.snp.width)
            const.top.equalTo(sloganLabel.snp.bottom).offset(10)
            const.bottom.equalTo(register.snp.top)

        }

        vStack.snp.makeConstraints { const in
            const.centerX.equalTo(scrollView)
            const.width.equalTo(view.snp.width).inset(20)
            const.top.equalTo(scrollView).inset(10)
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
            const.bottom.equalTo(view.safeAreaLayoutGuide)
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
                
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                let wizardController =    WizardController(collectionViewLayout: layout)
                
                self.navigationController?.setViewControllers([wizardController], animated: false)
                
                HealthAndFitnessBase.shared.showToastMessage(title: "Login", message: "Login successful", type: 0)
                KeychainWrapper.standard.set( "Bearer \(response["accessToken"].stringValue)", forKey: "accessToken")
                KeychainWrapper.standard.set( true, forKey: "isLoggedIn")
                KeychainWrapper.standard.set( false, forKey: "isWizardCompleted")
                
            }else{
                
                HealthAndFitnessBase.shared.showToastMessage(title: "Login", message: response["data"].stringValue)
                
            }
            
            
            
        }){errorString in
            
            
            HealthAndFitnessBase.shared.showToastMessage(title: "Login", message: "Something went wrong. Please try again")
            
        }
        
        
    }
    
}
