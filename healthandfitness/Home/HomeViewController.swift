//
//  HomeViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-07.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import Kingfisher

protocol HomeViewControllerDelegate {
    func onExerciseClick()
}

class HomeViewController: UIViewController {
    
    var delegate: HomeViewControllerDelegate?
    
    var exerciseArray : JSON = ""
    
    
    var headerTitles : [String] = ["Popular Workouts","Today Plan"]
    
    let greeting: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Regular", size: 14)
        lbl.textAlignment = .left
        lbl.textColor = .black
        
        return lbl
    }()
    let userName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Medium", size: 20)
        lbl.textAlignment = .left
        lbl.textColor = .black
        
        return lbl
    }()
    
    
    let tableView : UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 100, y: 101, width: 202, height: 2 - 1))
        myTableView.register(PopularCell.self, forCellReuseIdentifier: "popularCell")
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return myTableView
        
    }()
    
    let sideMenuToggle : UIImageView = {
        let imgView =   UIImageView(image: #imageLiteral(resourceName: "side_menu"))
        imgView.contentMode = .scaleAspectFill
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(greeting)
        view.addSubview(userName)
        view.addSubview(tableView)
        view.addSubview(sideMenuToggle)
        
        setupConstraint()
        greetingLogic()
        homeNetworkRequest()
        profileNetworkRequest()
    }
    func setupConstraint(){
        
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0);
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = 20
        tableView.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        
        tableView.register(PopularCell.self, forCellReuseIdentifier: "popularCell")
        tableView.register(PlanCell.self, forCellReuseIdentifier: "planCell")
        tableView.register(HeaderCell.self,
                           forHeaderFooterViewReuseIdentifier: "headerCell")
        
        
        sideMenuToggle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeMenu(sender:))))
        
        
        greeting.snp.makeConstraints { const in
            
            
            const.leading.equalTo(view.snp.leading).offset(20)
            const.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            
            
        }
        sideMenuToggle.snp.makeConstraints { const in
            
            
            const.trailing.equalTo(view.snp.trailing).offset(-20)
            const.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            const.height.width.equalTo(25)
            
            
        }
        userName.snp.makeConstraints { const in
            
            
            const.leading.equalTo(view.snp.leading).offset(20)
            const.top.equalTo(greeting.snp.bottom).offset(10)
            
            
        }
        
        tableView.snp.makeConstraints { const in
            
            
            const.leading.equalTo(view.snp.leading)
            const.trailing.equalTo(view.snp.trailing)
            const.bottom.equalTo(view.snp.bottom)
            const.top.equalTo(userName.snp.bottom)
            
            
        }
        
    }
    
    func greetingLogic() {
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date as Date)
        let hourInt = Int(currentHour.description)!
        
        
        if hourInt >= 12 && hourInt <= 16 {
            greeting.text = "Good Afternoon"
        }
        else if hourInt >= 0 && hourInt <= 12 {
            greeting.text = "Good Morning"
        }
        else if hourInt >= 16 && hourInt <= 24 {
            greeting.text = "Good Evening"
        }
        
    }
    func homeNetworkRequest () {
        
        
        NetworkManager.shared.defaultNetworkRequest(url: HealthAndFitnessBase.BaseURL + "exercise/home", header: ["Authorization":(KeychainWrapper.standard.string(forKey: "accessToken") ?? "")], requestMethod: .get, showIndicator: true, indicatorParent: self.view, success: { response in
            
            
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
    func profileNetworkRequest () {
        
        
        NetworkManager.shared.defaultNetworkRequest(url: HealthAndFitnessBase.BaseURL + "user", header: ["Authorization":(KeychainWrapper.standard.string(forKey: "accessToken") ?? "")], requestMethod: .get, success: { response in
            
            
            if response["status"].boolValue {
                
                KeychainWrapper.standard.set( response["data"]["name"].stringValue, forKey: "userName")
                KeychainWrapper.standard.set( response["data"]["email"].stringValue, forKey: "email")
                KeychainWrapper.standard.set( response["data"]["telephone"].stringValue, forKey: "telephone")
                self.userName.text = response["data"]["name"].stringValue
                
            }else{
                
                HealthAndFitnessBase.shared.showToastMessage(title: "Home", message: response["data"].stringValue)
                
            }
        }){errorString in
            print(errorString)
            
            HealthAndFitnessBase.shared.showToastMessage(title: "Home", message: "Something went wrong. Please try again")
            
        }
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }else{
            return exerciseArray.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! PopularCell
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "planCell", for: indexPath) as! PlanCell
            cell.exerciseName.text =  exerciseArray[indexPath.row]["name"].stringValue
            cell.exerciseImage.kf.setImage(with: URL(string:   exerciseArray[indexPath.row]["coverImageUrl"].stringValue))
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.section==0){
            return 150
        }else{
            return 120
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                "headerCell") as! HeaderCell
        view.title.text = headerTitles[section]
        
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1){
            let exerciseDetailViewController = ExerciseDetailViewController()
            exerciseDetailViewController.selectedExercise = exerciseArray[indexPath.row]
            exerciseDetailViewController.isDefaultCategory = true
            navigationController?.pushViewController(exerciseDetailViewController, animated: false)
        }
    }
    
    @objc func closeMenu(sender : UIButton){
        
        self.sideMenuController?.showRightView(animated: true)
    }
    
}

