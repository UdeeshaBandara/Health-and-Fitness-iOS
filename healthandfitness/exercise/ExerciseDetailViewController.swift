//
//  ExerciseDetailViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-10.
//

import UIKit

class ExerciseDetailViewController: UIViewController {
    
    
    let workout: UILabel = {
        let lbl = UILabel()
        lbl.text = "Workout"
        lbl.font = UIFont(name: "Roboto-MediumItalic", size: 20)
        lbl.textAlignment = .center
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
        lbl.text = "Hand Training"
        lbl.font = UIFont(name: "Roboto-MediumItalic", size: 16)
        lbl.textAlignment = .left
        lbl.textColor = .black
        
        return lbl
    }()
    
    let exerciseDescription: UILabel = {
        let lbl = UILabel()
        lbl.text = "The lower abdomen and hips are the most difficult areas of the body to reduce when we are on a diet. Even so, in this area, especially the legs as a whole, you can reduce weight even if you don't use tools."
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(workout)
        
        vStack.addArrangedSubview(exerciseImage)
        vStack.addArrangedSubview(exerciseTitle)
        vStack.addArrangedSubview(exerciseDescription)
        
        view.addSubview(vStack)
        view.addSubview(tableView)
        view.addSubview(startButton)
        
        setupConstraint()
        
        setupTableView()
        
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
            
            
            const.centerX.equalTo(view)
            const.width.equalTo(view).inset(20)
            const.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            
            
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
    }
}
extension ExerciseDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =   tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! ExerciseCell
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
