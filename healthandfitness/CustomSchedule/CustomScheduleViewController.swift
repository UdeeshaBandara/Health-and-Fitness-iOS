//
//  CustomScheduleViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-12.
//

import UIKit

class CustomScheduleViewController: UIViewController {
    
    
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
    }
    func setupConstraint(){
        
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
    
        tableView.contentInset.bottom = 90
        tableView.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        
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
        
        self.present(ExerciseListViewController(), animated: true, completion: nil)
    }
    
    
}
extension CustomScheduleViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planCell", for: indexPath) as! PlanCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
