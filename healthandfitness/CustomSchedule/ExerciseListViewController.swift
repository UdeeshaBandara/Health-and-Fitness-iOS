//
//  ExerciseListViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-12.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import Kingfisher

class ExerciseListViewController: UIViewController {
    
    
    var exerciseArray : JSON = ""
     
    
    let scheduleName  = UITextField()
    
    let titleExercise: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Thin", size: 14)
        lbl.textAlignment = .left
        lbl.textColor = .black
        lbl.text = "Select Your Exercises"
        return lbl
    }()
    
    let tableView : UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 100, y: 101, width: 202, height: 2 - 1))
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return myTableView
        
    }()
    
    
    let submitButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        return button
        
    }()
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scheduleName)
        view.addSubview(titleExercise)
        
        view.addSubview(tableView)
        view.addSubview(submitButton)
        setupConstraint()
        exerciseListNetworkRequest()
        
        submitButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
    }
    func setupConstraint(){
        
        scheduleName.updateDesign()
        scheduleName.attributedPlaceholder = NSAttributedString(string: "Enter Schedule Name", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)])
        
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
    
        tableView.contentInset.bottom = 90
        tableView.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        
        tableView.register(ExerciseSelectCell.self, forCellReuseIdentifier: "exerciseSelectCell")
        
        
        scheduleName.snp.makeConstraints { const in
            
            const.width.equalTo(view.snp.width).inset(20)
            const.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            const.centerX.equalTo(view)
            const.height.equalTo(45)
        }
        
        titleExercise.snp.makeConstraints { const in
            const.centerX.equalTo(view)
            const.width.equalTo(view.snp.width).inset(20)
            const.top.equalTo(scheduleName.snp.bottom).offset(20)
        }
        
        tableView.snp.makeConstraints { const in
            
            const.width.equalTo(view.snp.width).inset(20)
            const.centerX.equalTo(view)
            
            const.top.equalTo(titleExercise.snp.bottom).offset(20)
            const.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
        submitButton.snp.makeConstraints { const in
            
            const.width.equalTo(view.snp.width).inset(20)
            const.centerX.equalTo(view)
            const.height.equalTo(45)
            const.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            
        }
        
    }
    @objc func nextStep(sender : UIButton){
        if(scheduleName.text == ""){
            HealthAndFitnessBase.shared.showToastMessage(title: "Custom schedule", message: "Please enter schedule name")
        }else{
            var selectedExercises = [(JSON)]()
            for item in self.exerciseArray.arrayValue {
                if(item["isChecked"].boolValue){
                    if(item["repCount"].intValue == 0 || item["setCount"].intValue == 0 ){
                        
                        HealthAndFitnessBase.shared.showToastMessage(title: "Custom schedule", message: "Please enter rep and set counts")
                        
                        break;
                    }else{
                        let sendingItem: JSON = JSON([ "exerciseId" :  item["id"], "repCount" :  item["repCount"], "setCount" : item["setCount"]])
                       
                        selectedExercises.append(sendingItem)
                    }
                }
            }
            if(selectedExercises.count>0){
                saveCustomeScheduleNetworkRequest(selectedExercises: selectedExercises)
            }
           
        }
    }
    
    func exerciseListNetworkRequest () {
        
        
        NetworkManager.shared.defaultNetworkRequest(url: HealthAndFitnessBase.BaseURL + "exercise", header: ["Authorization":(KeychainWrapper.standard.string(forKey: "accessToken") ?? "")], requestMethod: .get, showIndicator: true, indicatorParent: self.view, success: { response in
            
            
            if response["status"].boolValue {
                
                self.exerciseArray = response["data"]
                self.tableView.reloadData()
                
            }else{
                
                HealthAndFitnessBase.shared.showToastMessage(title: "Custom schedule", message: response["data"].stringValue)
                
            }
        }){errorString in
            print(errorString)
            
            HealthAndFitnessBase.shared.showToastMessage(title: "Custom schedule", message: "Something went wrong. Please try again")
            
        }
    }
    func saveCustomeScheduleNetworkRequest ( selectedExercises : [(JSON)]) {
   

    
        
        let param = [
            "name" : scheduleName.text!,
            "exercises" : NSArray(array:[selectedExercises]),
        ] as [String : Any]
        
        print(param)
        
        NetworkManager.shared.jsonArrayRequest(url: HealthAndFitnessBase.BaseURL + "custom/exercise", header: ["Authorization":(KeychainWrapper.standard.string(forKey: "accessToken") ?? "")], param: selectedExercises,  success: { response in
            
            
            if response["status"].boolValue {
                
                self.dismiss(animated: true)
                
            }else{
                
                HealthAndFitnessBase.shared.showToastMessage(title: "Custom schedule", message: response["data"].stringValue)
                
            }
        }){errorString in
            print(errorString)
            
            HealthAndFitnessBase.shared.showToastMessage(title: "Custom schedule", message: "Something went wrong. Please try again")
            
        }
    }
    
}
extension ExerciseListViewController: UITableViewDelegate, UITableViewDataSource{
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseSelectCell", for: indexPath) as! ExerciseSelectCell
         
        cell.selectionStyle = .none
        cell.exerciseLabel.text = exerciseArray[indexPath.row]["name"].stringValue
        cell.repCount.text = exerciseArray[indexPath.row]["repCount"].intValue == 0 ? "" : exerciseArray[indexPath.row]["repCount"].stringValue
        cell.setCount.text = exerciseArray[indexPath.row]["setCount"].intValue == 0 ? "" : exerciseArray[indexPath.row]["setCount"].stringValue 
        cell.exerciseImage.kf.setImage(with: URL(string:   exerciseArray[indexPath.row]["coverImageUrl"].stringValue))
        if(exerciseArray[indexPath.row]["isChecked"].boolValue){
            cell.selectionSwitch.isOn = true
            cell.hStackRepSet.isHidden = false
        }else{
            cell.selectionSwitch.isOn = false
            cell.hStackRepSet.isHidden = true
        }
        
        cell.onSelectExercise = { isSelected in
         
            if(isSelected){
                self.exerciseArray[indexPath.row]["isChecked"] = true
            }else{
                self.exerciseArray[indexPath.row]["isChecked"] = false
            }
            
            cell.selectionSwitch.isOn = isSelected
            tableView.reloadData()
        }
        cell.onRepChange = { repCount in
         
        print(repCount)
            self.exerciseArray[indexPath.row]["repCount"] = JSON(repCount)
            
 
        }
        
        cell.onSetChange = { setCount in
            print(setCount)
        
            self.exerciseArray[indexPath.row]["setCount"] = JSON(setCount)
            
     
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(exerciseArray[indexPath.row]["isChecked"].boolValue){
            return 160
            
        }else{
            return 100
        }
        
    }
}
