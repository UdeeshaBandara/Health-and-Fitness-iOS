//
//  ExerciseTrackViewController.swift
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

class ExerciseTrackViewController: UIViewController {
    
    private weak var displayLink: CADisplayLink?
    private var startTime: CFTimeInterval?
    private var elapsed: CFTimeInterval = 0
    private var priorElapsed: CFTimeInterval = 0
    
    var selectedExerciseList : JSON = ""
    
    var completedExerciseList : JSON = ""
    
    var isDefaultCategory : Bool = true
    
    var currentExerciseIndex : Int = -1
    
    let secondsLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.font = UIFont(name: "Roboto-Bold", size: 40)
        lbl.textAlignment = .justified
        lbl.textColor = .black
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.sizeToFit()
        lbl.text = " : 00"
        lbl.numberOfLines = 10
        return lbl
    }()
    
    let minutesLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.font = UIFont(name: "Roboto-Bold", size: 60)
        lbl.textAlignment = .right
        lbl.textColor = .black
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.sizeToFit()
        lbl.text = "00"
        lbl.numberOfLines = 5
        return lbl
    }()
    
    let hStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
        return stackView
        
    }()
    let hStackButtons : UIStackView = {
        
        let stackView = UIStackView()
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.axis = .horizontal
        return stackView
        
    }()
    
    let startPauseButton : UIImageView = {
        let imgView =   UIImageView(image: #imageLiteral(resourceName: "play"))
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 20
        imgView.clipsToBounds = true
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    let resetButton : UIImageView = {
        let imgView =   UIImageView(image: #imageLiteral(resourceName: "reset"))
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 20
        imgView.clipsToBounds = true
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    let tableView : UITableView = {
        
        let myTableView = UITableView(frame: CGRect(x: 100, y: 101, width: 202, height: 2 - 1))
        myTableView.register(ExerciseTrackCell.self, forCellReuseIdentifier: "exerciseTrackCell")
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return myTableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        hStack.addArrangedSubview(minutesLabel)
        hStack.addArrangedSubview(secondsLabel)
        hStackButtons.addArrangedSubview(startPauseButton)
        hStackButtons.addArrangedSubview(resetButton)
        view.addSubview(hStack)
        view.addSubview(hStackButtons)
        
        view.addSubview(tableView)
        setupConstraint()
        setupTableView()
        
        startPauseButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startPauseTimer(sender:))))
        resetButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resetTimer(sender:))))
        
        
        
        navigationItem.title = "Track Workout"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        
        readStoredData(storeKey: isDefaultCategory ? "completedExercises" : "completedCustomExercises")
        
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
            const.top.equalTo(hStackButtons.snp.bottom).offset(10)
            const.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(10)
            
            
        }
    }
    
    
    func setupConstraint(){
        
        
        hStack.snp.makeConstraints { const in
            
            const.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            const.centerX.equalTo(view)
            const.width.equalTo(view.snp.width).inset(20)
            
            
        }
        hStackButtons.snp.makeConstraints { const in
            
            const.top.equalTo(hStack.snp.bottom).offset(20)
            const.centerX.equalTo(view)
            const.width.equalTo(100)
            
            
        }
        startPauseButton.snp.makeConstraints { const in
            
            const.width.height.equalTo(40)
            
            
        }
        resetButton.snp.makeConstraints { const in
            
            const.width.height.equalTo(40)
            
            
        }
        
    }
    func readStoredData(storeKey key : String){
        let completedExercises = KeychainWrapper.standard.string(forKey: key) ?? "[]"
        
        if let jsonData = completedExercises.data(using: .utf8) {
            let json = try? JSON(data: jsonData)
            
            completedExerciseList = json ?? "[]"
            
            
        } else {
            print("Invalid JSON string")
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            //            if displayLink == nil {
            //                HealthAndFitnessBase.shared.showToastMessage(title: "Tracker", message: "Successfully added a new reminder to your calendar",type: 0)
            //            }
        }
    }
    
}
extension ExerciseTrackViewController{
    func startDisplayLink() {
        startTime = CACurrentMediaTime()
        let displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLink(_:)))
        displayLink.add(to: .main, forMode: .common)
        self.displayLink = displayLink
    }
    
    func stopDisplayLink() {
        displayLink?.invalidate()
    }
    
    @objc func handleDisplayLink(_ displayLink: CADisplayLink) {
        guard let startTime = startTime else { return }
        elapsed = CACurrentMediaTime() - startTime
        updateUI()
    }
    
    func updateUI() {
        let totalElapsed = elapsed + priorElapsed
        
        let hundredths = Int((totalElapsed * 100).rounded())
        let (minutes, hundredthsOfSeconds) = hundredths.quotientAndRemainder(dividingBy: 60 * 100)
        let (seconds, _) = hundredthsOfSeconds.quotientAndRemainder(dividingBy: 100)
        
        minutesLabel.text = String(format: "%02d", minutes)
        secondsLabel.text = " : " + String(format: "%02d", seconds)
        
    }
    @objc private func startPauseTimer(sender : UITapGestureRecognizer) {
        
        
        if displayLink == nil {
            startDisplayLink()
            startPauseButton.image =   #imageLiteral(resourceName: "pause")
        }else{
            priorElapsed += elapsed
            elapsed = 0
            displayLink?.invalidate()
            startPauseButton.image =   #imageLiteral(resourceName: "play")
        }
        
    }
    
    @objc private func resetTimer(sender : UITapGestureRecognizer) {
        
        stopDisplayLink()
        elapsed = 0
        priorElapsed = 0
        updateUI()
        startPauseButton.image =   #imageLiteral(resourceName: "play")
    }
    
    
}
extension ExerciseTrackViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedExerciseList["exercises"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =   tableView.dequeueReusableCell(withIdentifier: "exerciseTrackCell", for: indexPath) as! ExerciseTrackCell
        //
        //        if(currentExerciseIndex > indexPath.row){
        //
        //            cell.markAsCompleteButton.isOn = true
        //        }else{
        //            cell.markAsCompleteButton.isOn = false
        //
        //        }
        
        if (currentExerciseIndex == indexPath.row){
            
            cell.mainView.layer.borderColor =   #colorLiteral(red: 0.9386845231, green: 0.352627635, blue: 0.1541865468, alpha: 0.8871326573)
            cell.mainView.layer.borderWidth = 2
            
        }else{
            cell.mainView.layer.borderColor =  #colorLiteral(red: 0.8944590688, green: 0.9143784642, blue: 0.9355253577, alpha: 1)
            cell.mainView.layer.borderWidth = 0
        }
        
        if(isCompleteButtonEnabled(cellIndex: indexPath.row)){
            
            cell.markAsCompleteButton.isEnabled = true
            cell.markAsCompleteButton.alpha = 1
        }else{
            cell.markAsCompleteButton.isEnabled = false
            cell.markAsCompleteButton.alpha = 0.5
        }
        
      
        cell.exerciseName.text =  selectedExerciseList["exercises"][indexPath.row]["name"].stringValue
        
        if(isDefaultCategory){
            cell.repSetCount.text =  "3 Reps X 4 Sets"
            
        }else{
            
            cell.repSetCount.text =  "\(selectedExerciseList["exercises"][indexPath.row]["customScheduleExercises"]["repCount"].stringValue) Reps X \(selectedExerciseList["exercises"][indexPath.row]["customScheduleExercises"]["setCount"].stringValue) Sets"
        }
        cell.exerciseImage.kf.setImage(with: URL(string:   selectedExerciseList["exercises"][indexPath.row]["coverImageUrl"].stringValue))
        
        cell.onCompleteClick = {
            self.manageLocalStorage(cellIndex: indexPath.row)
            
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        currentExerciseIndex = indexPath.row
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action: UIContextualAction = UIContextualAction(style: .normal, title: nil) { (_, _, completionHandler) in
            
            
            completionHandler(true)
        }
        
        action.image = UIImage(systemName: "info.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        action.backgroundColor = UIColor.systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }
    func manageLocalStorage(cellIndex row : Int){
        let valueExists = self.completedExerciseList.contains { (_, json) -> Bool in
            
            return json["categoryId"].intValue == self.selectedExerciseList["id"].intValue
        }
        if(valueExists){
            
            if let index = self.completedExerciseList.array!.firstIndex(where: { $0["categoryId"].intValue == self.selectedExerciseList["id"].intValue }) {
                
                
                if let numbers = self.completedExerciseList[index]["selectedExercises"].arrayObject as? [Int] {
                    if numbers.contains(self.selectedExerciseList[row]["id"].intValue) {
                        
                    } else {
                        self.completedExerciseList[index]["selectedExercises"].arrayObject?.append(self.selectedExerciseList["exercises"][row]["id"].intValue)
                        
                        
                    }
                }else{
                    print("invalid json")
                }
                
                if let jsonString = self.completedExerciseList.rawString() {
                    
                    KeychainWrapper.standard.set(jsonString, forKey: isDefaultCategory ? "completedExercises" : "completedCustomExercises")
                }
                
                
            } else {
                
            }
            
            
        }else{
            
            let markedExercise: [String: Any]  = [
                
                "categoryId": self.selectedExerciseList["id"].intValue,
                "selectedExercises": [self.selectedExerciseList["exercises"][row]["id"].intValue]
                
                
            ]
            
            let jsonObj = JSON([markedExercise])
           
            if let jsonArray1 = jsonObj.array, let jsonArray2 =  self.completedExerciseList.array {
             
                self.completedExerciseList.arrayObject = jsonArray1 + jsonArray2
            }
          

            if let jsonString = self.completedExerciseList.rawString() {
                 
                KeychainWrapper.standard.set(jsonString, forKey: isDefaultCategory ? "completedExercises" : "completedCustomExercises")
            }
            
            
        }
        
        
        self.readStoredData(storeKey: isDefaultCategory ? "completedExercises" : "completedCustomExercises")
        tableView.reloadData()
    }
    func isCompleteButtonEnabled(cellIndex row : Int) -> Bool{
        
        let valueExists = self.completedExerciseList.contains { (_, json) -> Bool in
            
            return json["categoryId"].intValue == self.selectedExerciseList["id"].intValue
        }
        
        if(valueExists){
            if let index = self.completedExerciseList.array!.firstIndex(where: { $0["categoryId"].intValue == self.selectedExerciseList["id"].intValue }) {
                
                
                if let numbers = self.completedExerciseList[index]["selectedExercises"].arrayObject as? [Int] {
                    if numbers.contains(self.selectedExerciseList["exercises"][row]["id"].intValue) {
                        return false
                    } else {
                        return true
                         
                    }
                }else{
                    return true
                }
                
            } else {
                return true
            }
            
        }else{
            return true
        }
    }
}
