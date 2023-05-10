//
//  ExerciseTrackViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-10.
//

import UIKit

class ExerciseTrackViewController: UIViewController {
    
    private weak var displayLink: CADisplayLink?
    private var startTime: CFTimeInterval?
    private var elapsed: CFTimeInterval = 0
    private var priorElapsed: CFTimeInterval = 0
    
    let trackWorkout: UILabel = {
        let lbl = UILabel()
        lbl.text = "Track Your Workout"
        lbl.font = UIFont(name: "Roboto-MediumItalic", size: 20)
        lbl.textAlignment = .center
        lbl.textColor = .black
        
        return lbl
    }()
    
    let secondsLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.font = UIFont(name: "Roboto-Regular", size: 20)
        lbl.textAlignment = .justified
        lbl.textColor = .black
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl.sizeToFit()
        lbl.numberOfLines = 10
        return lbl
    }()
    
    let minutesLabel: UILabel = {
        let lbl = UILabel()
        
        lbl.font = UIFont(name: "Roboto-Regular", size: 20)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        hStack.addArrangedSubview(minutesLabel)
        hStack.addArrangedSubview(secondsLabel)
        view.addSubview(trackWorkout)
        view.addSubview(hStack)
        setupConstraint()
        startDisplayLink()
    }
    
    func setupConstraint(){
        
        
        
        trackWorkout.snp.makeConstraints { const in

            const.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            const.centerX.equalTo(view)
            const.width.equalTo(view.snp.width).inset(20)


        }
        hStack.snp.makeConstraints { const in

            const.top.equalTo(trackWorkout.snp.bottom).offset(20)
            const.centerX.equalTo(view)
            const.width.equalTo(view.snp.width).inset(20)


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
    
    
    
}
