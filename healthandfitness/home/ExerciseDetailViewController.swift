//
//  ExerciseDetailViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-10.
//

import UIKit

class ExerciseDetailViewController: UIViewController {
    
    private weak var displayLink: CADisplayLink?
    private var startTime: CFTimeInterval?
    private var elapsed: CFTimeInterval = 0
    private var priorElapsed: CFTimeInterval = 0

    let scrollView = UIScrollView()

    
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
    let hStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
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
    
    let secondsLabel: UILabel = {
        let lbl = UILabel()
       
        lbl.font = UIFont(name: "Roboto-Regular", size: 12)
        lbl.textAlignment = .justified
        lbl.textColor = .black
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.sizeToFit()
        lbl.numberOfLines = 10
        return lbl
    }()
    
    let minutesLabel: UILabel = {
        let lbl = UILabel()
       
        lbl.font = UIFont(name: "Roboto-Regular", size: 12)
        lbl.textAlignment = .right
        lbl.textColor = .black
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.sizeToFit()
        lbl.text = "00"
        lbl.numberOfLines = 10
        return lbl
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(workout)
    
        vStack.addArrangedSubview(exerciseImage)
        vStack.addArrangedSubview(exerciseTitle)
        vStack.addArrangedSubview(exerciseDescription)
        hStack.addArrangedSubview(minutesLabel)
        hStack.addArrangedSubview(secondsLabel)
        vStack.addArrangedSubview(hStack)
   
        scrollView.addSubview(vStack)
        view.addSubview(scrollView)
        
        
        scrollView.contentInset.bottom = 20
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        setupConstraint()
        startDisplayLink()
        
    }
     

    func setupConstraint(){
        
        
        
        workout.snp.makeConstraints { const in
            
            
            const.centerX.equalTo(view)
            const.width.equalTo(view).inset(20)
            const.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            
            
        }
        scrollView.snp.makeConstraints { const in
            const.top.equalTo(workout.snp.bottom).offset(20)
            const.centerX.equalTo(view.snp.centerX)
            const.width.equalTo(view.snp.width).inset(20)
            const.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            
            
        }
        
        vStack.snp.makeConstraints { const in
           
            const.top.equalTo(scrollView.snp.top)
            const.centerX.equalTo(scrollView.snp.centerX)
            
            const.bottom.equalTo(scrollView.snp.bottom)
            const.width.equalTo(scrollView.snp.width)
       
            
        }
        
    }
}
private extension ExerciseDetailViewController {
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

  
}
