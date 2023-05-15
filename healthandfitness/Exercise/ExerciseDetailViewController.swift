//
//  ExerciseDetailViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-10.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import Kingfisher
import EventKit
import EventKitUI

class ExerciseDetailViewController: UIViewController {
    
    var selectedExercise : JSON = ""
    
    var isDefaultCategory : Bool = true
    
    let store = EKEventStore()
    
    
    let workout: UILabel = {
        let lbl = UILabel()
        lbl.text = "Workout"
        lbl.font = UIFont(name: "Roboto-Bold", size: 20)
        lbl.textAlignment = .left
        lbl.textColor = .black
        
        return lbl
    }()
    
    
    let vStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing  = 15
        stackView.axis = .vertical
        return stackView
        
    }()
    
    
    
    let exerciseImage : UIImageView = {
        let imgView =   UIImageView(image: #imageLiteral(resourceName: "popular_image"))
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 20
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let exerciseTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Bold", size: 18)
        lbl.textAlignment = .left
        lbl.textColor = .black
        
        return lbl
    }()
    
    let exerciseDescription: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-Regular", size: 12)
        lbl.textAlignment = .justified
        lbl.textColor = .black
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.sizeToFit()
        lbl.numberOfLines = 10
        return lbl
    }()
    
    
    
    let tableView : UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 100, y: 101, width: 202, height: 2 - 1))
        myTableView.register(ExerciseCell.self, forCellReuseIdentifier: "exerciseCell")
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return myTableView
        
    }()
    
    let startButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Let's Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        
        return button
        
    }()
    let outerShade : UIView = {
        
        let outerView = UIView()
        outerView.clipsToBounds = false
        outerView.layer.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        outerView.clipsToBounds = true
        outerView.layer.cornerRadius = 20
        return outerView
        
    }()
    
    let subView : UIView = {
        
        let outerView = UIView()
        outerView.clipsToBounds = false
        outerView.layer.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        outerView.clipsToBounds = true
        outerView.layer.cornerRadius = 20
        return outerView
        
    }()
    
    let remindMeLaterButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Remind me later", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(workout)
        view.addSubview(remindMeLaterButton)
        
        subView.addSubview(exerciseImage)
        subView.addSubview(outerShade)
        
        vStack.addArrangedSubview(subView)
        vStack.addArrangedSubview(exerciseTitle)
        vStack.addArrangedSubview(exerciseDescription)
        
        view.addSubview(vStack)
        view.addSubview(tableView)
        view.addSubview(startButton)
        
        setupConstraint()
        
        setupTableView()
        populateData()
        
        startButton.addTarget(self, action: #selector(startAction), for: .touchUpInside)
        remindMeLaterButton.addTarget(self, action: #selector(remindLater), for: .touchUpInside)
    }
    func setupTableView(){
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.contentInset.bottom = 50
        tableView.contentInset.top = 20
        
        tableView.snp.makeConstraints { const in
            
            
            const.centerX.equalTo(view)
            const.width.equalTo(view) 
            const.top.equalTo(vStack.snp.bottom).offset(10)
            const.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(10)
            
            
        }
    }
    
    
    func setupConstraint(){
        
        
        
        workout.snp.makeConstraints { const in
            
            
            const.leading.equalTo(view).offset(20)
            const.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            
            
        }
        remindMeLaterButton.snp.makeConstraints { const in

 
            const.centerY.equalTo(workout)
            const.width.equalTo(160)
            const.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            
            
        }
        vStack.snp.makeConstraints { const in
            
            
            const.centerX.equalTo(view)
            const.width.equalTo(view).inset(20)
            const.top.equalTo(workout.snp.bottom).offset(20)
            
            
        }
        
        vStack.snp.makeConstraints { const in
            
            
            const.centerX.equalTo(view)
            const.width.equalTo(view).inset(20)
            const.top.equalTo(workout.snp.bottom).offset(20)
            
            
        }
        startButton.snp.makeConstraints { const in
            
            
            const.height.equalTo(45)
            const.centerX.equalTo(view)
            const.width.equalTo(view).inset(20)
            const.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(5)
            
        }
        subView.snp.makeConstraints { const in
            
            
            const.height.equalTo(200)
           
            
        }
        exerciseImage.snp.makeConstraints { const in
            
            
            const.edges.equalTo(subView)
           
            
        }
        outerShade.snp.makeConstraints { const in
            
            
            const.edges.equalTo(subView)
           
            
        }
    }
    func populateData(){
        exerciseTitle.text = selectedExercise["name"].stringValue
        exerciseDescription.text = selectedExercise["description"].stringValue
        exerciseImage.kf.setImage(with: URL(string:   selectedExercise["coverImageUrl"].stringValue))
        
        
    }
    @objc func startAction(sender : UIButton){
        let exerciseTrackViewController = ExerciseTrackViewController()
        exerciseTrackViewController.selectedExerciseList = selectedExercise["exercises"]
        exerciseTrackViewController.isDefaultCategory = isDefaultCategory
        navigationController?.pushViewController(exerciseTrackViewController, animated: false)
    }
    @objc func remindLater(sender : UIButton){
        let eventVC = EKEventEditViewController()
        
        
        store.requestAccess(to: .event){ [weak self] success, error in
            if success, error == nil{
                DispatchQueue.main.async {
                    guard let store = self?.store else {return}
                    let event = EKEvent(eventStore: store)
                    event.title = self?.selectedExercise["name"].stringValue
                    event.startDate = Date()
                    event.endDate = Date()
                    
                    
                    eventVC.eventStore = store
                    eventVC.event = event
                    eventVC.editViewDelegate = self
                    self?.present(eventVC, animated: true)
                    
                }
            }
            
        }
        
        
    }
}
extension ExerciseDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedExercise["exercises"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =   tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! ExerciseCell
        cell.exerciseName.text =  selectedExercise["exercises"][indexPath.row]["name"].stringValue
        if(isDefaultCategory){
            cell.repSetCount.text =  "3 Reps X 4 Sets"
        }else{
            
            cell.repSetCount.text =  "\(selectedExercise["exercises"][indexPath.row]["customScheduleExercises"]["repCount"].stringValue) Reps X \(selectedExercise["exercises"][indexPath.row]["customScheduleExercises"]["setCount"].stringValue) Sets"
        }
        cell.exerciseImage.kf.setImage(with: URL(string:   selectedExercise["exercises"][indexPath.row]["coverImageUrl"].stringValue))
   
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
 
}
extension ExerciseDetailViewController: EKEventEditViewDelegate {
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        
       
        controller.dismiss(animated: true, completion: {
            
             if(action == EKEventEditViewAction.saved){
                 HealthAndFitnessBase.shared.showToastMessage(title: "Reminder", message: "Successfully added a new reminder to your calendar",type: 0)
             }
        })
    }
}
