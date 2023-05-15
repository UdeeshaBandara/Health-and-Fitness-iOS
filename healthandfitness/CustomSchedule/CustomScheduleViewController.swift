//
//  CustomScheduleViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-12.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import Kingfisher

class CustomScheduleViewController: UIViewController {
    
    var exerciseArray : JSON = ""
    
   
    
    let emptyMsg: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Light", size: 18)
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        lbl.numberOfLines = 3
        lbl.text = "You don't have any customized schedules. Tap '+' to create new one"
        return lbl
    }()
    
    
    let tableView : UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 100, y: 101, width: 202, height: 2 - 1))
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return myTableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(emptyMsg)
        view.addSubview(tableView)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewSchedule))
        
        setupConstraint()
        customeScheduleNetworkRequest()
        
    }
    
    func setupConstraint(){
        
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
        
        tableView.contentInset.bottom = 90
        tableView.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self 
        
        tableView.register(PlanCell.self, forCellReuseIdentifier: "planCell")
        
        
        emptyMsg.snp.makeConstraints { const in
            
            const.center.equalTo(view)
            const.width.equalTo(view.snp.width).inset(20)
        }
        
        tableView.snp.makeConstraints { const in
            
            const.width.equalTo(view.snp.width)
            const.centerX.equalTo(view)
            
            const.top.equalTo(view.safeAreaInsets).offset(20)
            const.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        
    }
    @objc func addNewSchedule(sender : UIButton){
        let exerciseListViewController = ExerciseListViewController()
        let navigationController = UINavigationController(rootViewController: exerciseListViewController)

        self.present(navigationController, animated: true, completion: nil)
        exerciseListViewController.onDismiss = {
            self.customeScheduleNetworkRequest()
        }
    }
    
    func customeScheduleNetworkRequest () {
        
        
        NetworkManager.shared.defaultNetworkRequest(url: HealthAndFitnessBase.BaseURL + "custom/exercise", header: ["Authorization":(KeychainWrapper.standard.string(forKey: "accessToken") ?? "")], requestMethod: .get, showIndicator: true, indicatorParent: self.view, success: { response in
            
            
            if response["status"].boolValue {
                
                self.exerciseArray = response["data"]
                if(self.exerciseArray.count > 0){
                    self.emptyMsg.isHidden = true
                    self.tableView.isHidden = false
                }else{
                    self.emptyMsg.isHidden = false
                    self.tableView.isHidden = true
                }
                self.tableView.reloadData()
                
            }else{
                
                HealthAndFitnessBase.shared.showToastMessage(title: "Custom schedule", message: response["data"].stringValue)
                
            }
        }){errorString in
            print(errorString)
            
            HealthAndFitnessBase.shared.showToastMessage(title: "Custom schedule", message: "Something went wrong. Please try again")
            
        }
    }
    
    
}
extension CustomScheduleViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planCell", for: indexPath) as! PlanCell
        
        cell.exerciseName.text =  exerciseArray[indexPath.row]["name"].stringValue
        cell.exerciseImage.kf.setImage(with: URL(string:   "https://post.healthline.com/wp-content/uploads/2020/02/man-exercising-plank-push-up-732x549-thumbnail.jpg"))
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
            let exerciseDetailViewController = ExerciseDetailViewController()
            exerciseDetailViewController.selectedExercise = exerciseArray[indexPath.row]
            exerciseDetailViewController.isDefaultCategory = false
            navigationController?.pushViewController(exerciseDetailViewController, animated: false)
        
    }
    
}
