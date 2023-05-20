//
//  GoalViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-14.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import LGSideMenuController

class GoalViewController: UIViewController {
    
    var goalList : JSON = ""
    
    var selectedIndex : Int = -1
    
    var bmiValue : CGFloat = 0.0
    
    var values = [Page]()
    
    var isFromOnboarding : Bool = true
    
    var onGoalChangeDismiss: (() -> Void)?
    
    let tableView : UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 100, y: 101, width: 202, height: 2 - 1))
        myTableView.register(GoalCell.self, forCellReuseIdentifier: "goalCell")
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return myTableView
        
    }()
    
    let letsStarteButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Let's start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 14)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView) 
        view.addSubview(letsStarteButton)
        setupConstraint()
        setupTableView()
        goalListNetworkRequest()
        
        letsStarteButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        
        navigationItem.title = isFromOnboarding ? "Select your Goal" : "Change my Goal"
        letsStarteButton.setTitle(isFromOnboarding ? "Let's start" : "Change my Goal", for: .normal)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        if(!isFromOnboarding){
            selectedIndex = KeychainWrapper.standard.integer(forKey: "personalGoalsId") ?? -1
            tableView.reloadData()
        }
        
    }
    
    func setupConstraint(){
        
        
        tableView.snp.makeConstraints { const in
            
            const.centerX.equalTo(view)
            const.width.equalTo(view).inset(10)
            const.bottom.equalTo(view).offset(10)
            const.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            
        }
        
        letsStarteButton.snp.makeConstraints { const in
            
            const.width.equalTo(view).inset(20)
            const.height.equalTo(45)
            const.centerX.equalTo(view)
            const.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            
        }
        
    }
    
    func setupTableView(){
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.contentInset.bottom = 50
        tableView.contentInset.top = 20
    
    }
    
    @objc private func handleNext() {
        if(selectedIndex == -1){
            HealthAndFitnessBase.shared.showToastMessage(title: "Personal Goal", message: "Please select your goal")
            
            
        }else if(isFromOnboarding){
            
            updateProfileNetworkRequest()
        }else{
            
            let popupViewController = PopupViewController()
            popupViewController.type = 3
            popupViewController.messageText = "Are you sure you want to change your goal?"
            presentPopup(viewControllerInstance: popupViewController)
            
            
        }
        
    }
    func goalListNetworkRequest () {
        
        
        NetworkManager.shared.defaultNetworkRequest(url: HealthAndFitnessBase.BaseURL + "user/goals", header: ["Authorization":(KeychainWrapper.standard.string(forKey: "accessToken") ?? "")], requestMethod: .get, showIndicator: true, indicatorParent: self.view, success: { response in
            
            
            if response["status"].boolValue {
                
                self.goalList = response["data"]
                self.tableView.reloadData()
                
            }else{
                
                HealthAndFitnessBase.shared.showToastMessage(title: "Personal Goal", message: response["data"].stringValue)
                
            }
        }){errorString in
            print(errorString)
            
            HealthAndFitnessBase.shared.showToastMessage(title: "Personal Goal", message: "Something went wrong. Please try again")
            
        }
    }
    
    func updateProfileNetworkRequest () {
        
        let param = [
            
            "gender" : values[0].value,
            "weight" : values[3].value,
            "age" : values[1].value,
            "bmi" : bmiValue,
            "height" : values[2].value,
            "goalId" : selectedIndex,
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
    func updatePersonalGoalNetworkRequest () {
        
        let param = [
            "personalGoalsId" : selectedIndex,
        ] as [String : Any]
        
       
        NetworkManager.shared.defaultNetworkRequest(url: HealthAndFitnessBase.BaseURL + "user/goals", header: ["Authorization":(KeychainWrapper.standard.string(forKey: "accessToken") ?? "")],param: param, requestMethod: .post, showIndicator: true, indicatorParent: self.view, encoder: JSONEncoding.default, success: { response in
     
            if response["status"].boolValue {
               
                self.onGoalChangeDismiss?()
                KeychainWrapper.standard.set("[]", forKey: "completedExercises")
                KeychainWrapper.standard.set("[]", forKey: "completedCustomExercises")
                KeychainWrapper.standard.set( self.selectedIndex, forKey: "personalGoalsId")
                HealthAndFitnessBase.shared.showToastMessage(title: "Personal Info", message: response["data"].stringValue, type: 0)
                self.navigationController?.popViewController(animated: true) 
                
            }else{
                
                HealthAndFitnessBase.shared.showToastMessage(title: "Personal Info", message: response["data"].stringValue)
                
            }
            
            
            
        }){errorString in
            
            
            HealthAndFitnessBase.shared.showToastMessage(title: "Personal Info", message: "Something went wrong. Please try again")
            
        }
        
        
    }
    func presentPopup(viewControllerInstance popupViewController : PopupViewController) {
        
        
        popupViewController.modalPresentationStyle = .overCurrentContext
        popupViewController.modalTransitionStyle = .crossDissolve
        popupViewController.delegate = self
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(popupViewController, animated: true, completion: nil)
        }
    }
    
}
extension GoalViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =   tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as! GoalCell
        cell.goalName.text = goalList[indexPath.row]["name"].stringValue
        cell.goalImage.kf.setImage(with: URL(string:   goalList[indexPath.row]["iconUrl"].stringValue))
        if(selectedIndex == goalList[indexPath.row]["id"].intValue){
            cell.mainView.layer.borderColor =   #colorLiteral(red: 0.9386845231, green: 0.352627635, blue: 0.1541865468, alpha: 0.8871326573)
        }else{
            cell.mainView.layer.borderColor =  #colorLiteral(red: 0.8944590688, green: 0.9143784642, blue: 0.9355253577, alpha: 1)
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        (tableView.cellForRow(at: indexPath) as! GoalCell).mainView.layer.borderColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        selectedIndex = goalList[indexPath.row]["id"].intValue
        tableView.reloadData()
    }
    
}
extension GoalViewController : LogoutViewControllerDelegate{
    func onChangeGoal() {
        updatePersonalGoalNetworkRequest()
    }
    
    func onLogout() {
         
    }
    
    func onClearLogs() {
         
    }
    
    
}
