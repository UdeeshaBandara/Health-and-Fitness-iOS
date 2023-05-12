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
    
    let titleExercise: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Medium", size: 20)
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.text = "Select Your Exercises"
        return lbl
    }()
    
    let tableView : UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 100, y: 101, width: 202, height: 2 - 1))
        myTableView.register(PopularCell.self, forCellReuseIdentifier: "popularCell")
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return myTableView
        
    }()
    
    
    let nextButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        return button
        
    }()
    
   
    
    let checkboxImage : UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imgView.image = #imageLiteral(resourceName: "check_tick")
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(titleExercise)
        
        view.addSubview(tableView)
        view.addSubview(nextButton)
        setupConstraint()
        exerciseListNetworkRequest()
        
        nextButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
    }
    func setupConstraint(){
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0);
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = 90
        tableView.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        
        tableView.register(ExerciseSelectCell.self, forCellReuseIdentifier: "exerciseSelectCell")
        
        
        titleExercise.snp.makeConstraints { const in
            
            const.width.equalTo(view.snp.width).inset(20)
            const.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            const.centerX.equalTo(view)
        }
        
        tableView.snp.makeConstraints { const in
            
            const.width.equalTo(view.snp.width).inset(20)
            const.centerX.equalTo(view)
            
            const.top.equalTo(titleExercise.snp.bottom).offset(20)
            const.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
        nextButton.snp.makeConstraints { const in
            
            const.width.equalTo(view.snp.width).inset(20)
            const.centerX.equalTo(view)
            const.height.equalTo(45)
            
            
            const.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            
        }
        
    }
    @objc func nextStep(sender : UIButton){
        
        self.present(ExerciseListViewController(), animated: true, completion: nil)
    }
    
    func exerciseListNetworkRequest () {
        
        
        NetworkManager.shared.defaultNetworkRequest(url: HealthAndFitnessBase.BaseURL + "exercise", header: ["Authorization":(KeychainWrapper.standard.string(forKey: "accessToken") ?? "")], requestMethod: .get, showIndicator: true, indicatorParent: self.view, success: { response in
            
          
            if response["status"].boolValue {
                
                self.exerciseArray = response["data"]
                self.tableView.reloadData()
                
            }else{
                
                HealthAndFitnessBase.shared.showToastMessage(title: "Home", message: response["data"].stringValue)
                
            }
        }){errorString in
            print(errorString)
            
            HealthAndFitnessBase.shared.showToastMessage(title: "Home", message: "Something went wrong. Please try again")
            
        }
    }
    
}
extension ExerciseListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseSelectCell", for: indexPath) as! ExerciseSelectCell
       
//        cell.accessoryView =  checkboxImage
           
      
        cell.exerciseLabel.text = exerciseArray[indexPath.row]["name"].stringValue
        cell.exerciseImage.kf.setImage(with: URL(string:   exerciseArray[indexPath.row]["coverImageUrl"].stringValue))
        if(exerciseArray[indexPath.row]["isChecked"].boolValue){
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if( cell.accessoryType == .checkmark){
                exerciseArray[indexPath.row]["isChecked"] = false
                cell.accessoryType = .none
            }else{
                exerciseArray[indexPath.row]["isChecked"] = true
                cell.accessoryType = .checkmark
            }
            
        }
    }
    
}
