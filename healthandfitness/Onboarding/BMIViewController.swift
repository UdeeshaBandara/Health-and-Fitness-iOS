//
//  BMIViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-09.
//

import UIKit
import GaugeSlider 
import SnapKit
import LGSideMenuController
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper


class BMIViewController: UIViewController {
    
    var values = [Page]()
    
    let mainTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Bold", size: 24)
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.text = "Your BMI value"
        return lbl
    }()
    
    let gaugeSliderView: GaugeSliderView = {
        let width = UIScreen.main.bounds.width
        let gaugeSliderView = GaugeSliderView()
        gaugeSliderView.frame = CGRect(x: width * 0.05, y: 200, width: width * 0.9, height: width * 0.9)
        gaugeSliderView.blankPathColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
        gaugeSliderView.fillPathColor =  #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        gaugeSliderView.indicatorColor = UIColor(red: 94/255, green: 187/255, blue: 169/255, alpha: 1)
        gaugeSliderView.unitColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        gaugeSliderView.placeholderColor = UIColor(red: 139/255, green: 154/255, blue: 158/255, alpha: 1)
        gaugeSliderView.unitIndicatorColor = .white
        gaugeSliderView.customControlColor = UIColor(red: 47/255, green: 190/255, blue: 169/255, alpha: 1)
        gaugeSliderView.isUserInteractionEnabled = false
        gaugeSliderView.unit = ""
        gaugeSliderView.maxValue = 45
        gaugeSliderView.minValue = 14
        gaugeSliderView.placeholderFont = UIFont(name: "Roboto-Regular", size: 16)!
        gaugeSliderView.unitIndicatorFont = UIFont(name: "Roboto-Regular", size: 16)!
        gaugeSliderView.unitFont = UIFont.systemFont(ofSize: 40)
        gaugeSliderView.placeholder = "BMI"
        gaugeSliderView.delegationMode = .immediate(interval: 3)
        
        
        return gaugeSliderView
    }()
    
    
    let continueButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainTitle)
        view.addSubview(gaugeSliderView)
        view.addSubview(continueButton)
        
        setupConstraint()
        
        continueButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        calculateBMI()
        
    }
    
    func setupConstraint(){
        mainTitle.snp.makeConstraints { const in
            
            const.width.equalTo(view).inset(20)
            const.centerX.equalTo(view)
            const.top.equalTo(view.safeAreaLayoutGuide).inset(15)
            
        }
        continueButton.snp.makeConstraints { const in
            
            const.width.equalTo(view).inset(20)
            const.height.equalTo(45)
            const.centerX.equalTo(view)
            const.top.equalTo(gaugeSliderView.snp.bottom).offset(30)
            
        }
        
    }
    
    func calculateBMI() {
        
        
        let bmi = values[3].value / pow((values[2].value/100), 2)
        
        
        var interpretation = ""
        
        if (bmi > 25){
            interpretation = "Overweight"
        }
        else if (bmi >= 18.5){
            interpretation = "Healthy"
        }
        else{
            interpretation = "Underweight"
        }
        
        gaugeSliderView.customControlButtonTitle = interpretation
        gaugeSliderView.progress = CGFloat(bmi)
        
    }
    
    @objc private func handleNext() {
        updateProfileNetworkRequest()
        
    }
    func updateProfileNetworkRequest () {
        
        let param = [
            
            "gender" : values[0].value,
            "weight" : values[3].value,
            "age" : values[1].value,
            "bmi" : gaugeSliderView.progress,
            "height" : values[2].value
        ] as [String : Any]
        
       
        NetworkManager.shared.defaultNetworkRequest(url: HealthAndFitnessBase.BaseURL + "user/wizard", header: ["Authorization":(KeychainWrapper.standard.string(forKey: "accessToken") ?? "")],param: param, requestMethod: .post, showIndicator: true, indicatorParent: self.view, encoder: JSONEncoding.default, success: { response in
     
            if response["status"].boolValue {
                KeychainWrapper.standard.set( true, forKey: "isWizardCompleted")
                let sideMenuController = LGSideMenuController()
                sideMenuController.rootViewController = HomeViewController()
                sideMenuController.rightViewController = SideMenuViewController()
                sideMenuController.rightViewPresentationStyle = .slideBelowShifted
                sideMenuController.rightViewWidth = (UIScreen.main.bounds.width / 3) * 2
                self.navigationController?.setViewControllers([sideMenuController], animated: true)
                
                
                
            }else{
                
                HealthAndFitnessBase.shared.showToastMessage(title: "Personal Info", message: response["data"].stringValue)
                
            }
            
            
            
        }){errorString in
            
            
            HealthAndFitnessBase.shared.showToastMessage(title: "Personal Info", message: "Something went wrong. Please try again")
            
        }
        
        
    }
}