//
//  SwipingController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-07.
//

import Foundation
import UIKit
import SnapKit
import LGSideMenuController

class WizardController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let wizardCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    let pages = [
        Page(measurement: "", headerText: "", value: 0.0),
        Page(measurement: "Years", headerText: "Select age", value: 0.0),
        Page(measurement: "Centimeters", headerText: "Select height", value: 0.0),
        Page(measurement: "Kg", headerText: "Select weight", value: 0.0),
        
    ]
    
    
    let nextButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
        
    }()
    let previousButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Previous", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.titleLabel?.font =  UIFont(name: "Roboto-Bold", size: 18)
        button.backgroundColor = .white
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
        
    }()
    
    let hStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing  = 10
        stackView.axis = .horizontal
        return stackView
        
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pc.pageIndicatorTintColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3662820778)
        return pc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        wizardCollectionView.collectionViewLayout =  layout
        
        wizardCollectionView.backgroundColor = .blue
        wizardCollectionView.backgroundColor = .blue
        wizardCollectionView.dataSource = self
        wizardCollectionView.delegate = self
        setupContraints()
        
        wizardCollectionView.backgroundColor = .white
        wizardCollectionView.register(WizardCell.self, forCellWithReuseIdentifier: "wizardCell")
        wizardCollectionView.register(GenderCell.self, forCellWithReuseIdentifier: "genderCell")
        wizardCollectionView.showsVerticalScrollIndicator = false
        wizardCollectionView.showsHorizontalScrollIndicator = false
        wizardCollectionView.isPagingEnabled = true
    }
    
    
    @objc private func handleNext() {
        let sideMenuController = LGSideMenuController()
        sideMenuController.rootViewController = HomeViewController()
        sideMenuController.rightViewController = SideMenuViewController()
        sideMenuController.rightViewPresentationStyle = .slideBelowShifted
        sideMenuController.rightViewWidth = (UIScreen.main.bounds.width / 3) * 2
        
        if(nextButton.currentTitle=="Finish"){
            navigationController?.setViewControllers([sideMenuController], animated: true)
        }else{
            let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
            if(nextIndex==3){
                nextButton.setTitle("Finish", for: .normal)
            }
            wizardCollectionView.isPagingEnabled = false
            
            let indexPath = IndexPath(item: nextIndex, section: 0)
            pageControl.currentPage = nextIndex
            wizardCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            wizardCollectionView.isPagingEnabled = true
        }
    }
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        
        nextButton.setTitle("Next", for: .normal)
        
        wizardCollectionView.isPagingEnabled = false
        
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        wizardCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        wizardCollectionView.isPagingEnabled = true
    }
    
    func setupContraints() {
        view.addSubview(wizardCollectionView)
        wizardCollectionView.snp.makeConstraints { const in
            
            const.top.equalTo(view.snp.top)
            const.bottom.equalTo(view.snp.bottom)
            const.leading.equalTo(view.snp.leading)
            const.trailing.equalTo(view.snp.trailing)
            
        }
        hStack.addArrangedSubview(previousButton)
        hStack.addArrangedSubview(pageControl)
        hStack.addArrangedSubview(nextButton)
        view.addSubview(hStack)
        hStack.snp.makeConstraints { const in
            
            const.width.equalTo(view.snp.width).inset(20)
            const.centerX.equalTo(view.snp.centerX)
            const.bottom.equalTo(view.snp.bottom).inset(50)
            const.height.equalTo(50)
        }
        previousButton.snp.makeConstraints { const in
            
            const.width.equalTo(80)
            
        }
        nextButton.snp.makeConstraints { const in
            
            const.width.equalTo(80)
            
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        if((Int(x / view.frame.width))==2){
            nextButton.setTitle("Finish", for: .normal)
            
        }else{
            nextButton.setTitle("Next", for: .normal)
        }
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.row == 0){
            let cell = wizardCollectionView.dequeueReusableCell(withReuseIdentifier: "genderCell", for: indexPath) as! GenderCell
            
            return cell
        }else{
            let cell = wizardCollectionView.dequeueReusableCell(withReuseIdentifier: "wizardCell", for: indexPath) as! WizardCell
            
            cell.title.text = pages[indexPath.row].headerText
            cell.measurementUnit.text = pages[indexPath.row].measurement
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: (view.frame.height * 0.5))
    }
    
} 
