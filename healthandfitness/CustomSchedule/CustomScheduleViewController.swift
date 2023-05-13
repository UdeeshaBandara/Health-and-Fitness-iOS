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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(emptyMsg)
   
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewSchedule))
        
        setupConstraint()
    }
    func setupConstraint(){
        
        emptyMsg.snp.makeConstraints { const in
            
            const.center.equalTo(view)
            const.width.equalTo(view.snp.width).inset(20)
        }
        
        
        
    }
    @objc func addNewSchedule(sender : UIButton){
        
        self.present(ExerciseListViewController(), animated: true, completion: nil)
    }
    
    
}
extension CustomScheduleViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planCell", for: indexPath) as! PlanCell
        
        return cell
    }
    
    
}
