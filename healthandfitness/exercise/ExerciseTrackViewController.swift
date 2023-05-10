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
        lbl.font = UIFont(name: "Roboto-Medium", size: 20)
        lbl.textAlignment = .center
        lbl.textColor = .black
        
        return lbl
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        hStack.addArrangedSubview(minutesLabel)
        hStack.addArrangedSubview(secondsLabel)
        hStackButtons.addArrangedSubview(startPauseButton)
        hStackButtons.addArrangedSubview(resetButton)
        view.addSubview(trackWorkout)
        view.addSubview(hStack)
        view.addSubview(hStackButtons)
        setupConstraint()
        
        
        startPauseButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startPauseTimer(sender:))))
        resetButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resetTimer(sender:))))
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =   tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! ExerciseCell
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ExerciseTrackViewController(), animated: false)
    }
}
