//
//  SideMenuViewController.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-08.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let menuSubBackgroundView : UIView = {
        
        let view = UIView()
        return view
        
    }()
    let mainLogo : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "SplashScreen"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    let menuClose : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "close"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    let aboutUsLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.isUserInteractionEnabled = true
        lbl.text = "About Us"
        lbl.font = UIFont(name:"Roboto-MediumItalic",size:16)
        lbl.textAlignment = .center
       
        return lbl
    }()
    
    let contactUsLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.isUserInteractionEnabled = true
        lbl.text = "Contact Us"
        lbl.font = UIFont(name:"Roboto-MediumItalic",size:16)
        lbl.textAlignment = .center
       
        return lbl
    }()
    
    let bottomLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.text = "©2023 Health and Fitness. All rights reserved"
        lbl.font = UIFont(name:"Roboto-MediumItalic",size:10)
        lbl.textAlignment = .center
       
        return lbl
    }()
    let devider : UIView = {
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9611677527, green: 0.525033772, blue: 0.3648735881, alpha: 1)
        return view
        
    }()
    let deviderBottom : UIView = {
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9611677527, green: 0.525033772, blue: 0.3648735881, alpha: 1)
        return view
        
    }()
   
    
    let vStack : UIStackView = {
        
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing  = 10
        stackView.axis = .vertical
        return stackView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(mainLogo)
        view.addSubview(menuClose)
        
        view.addSubview(menuSubBackgroundView)
        menuSubBackgroundView.addSubview(scrollView)
        
        vStack.addArrangedSubview(aboutUsLabel)
        vStack.addArrangedSubview(devider)
        vStack.addArrangedSubview(contactUsLabel)
        
        scrollView.addSubview(vStack)
        
        menuSubBackgroundView.addSubview(deviderBottom)
        menuSubBackgroundView.addSubview(bottomLabel)
        
        setupConstraints()
        
        
        menuClose.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeMenu(sender:))))
        
        aboutUsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAboutUs(sender:))))
        
        contactUsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openContactUs(sender:))))
    
    }
    func setupConstraints(){
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset.bottom = 20
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        menuSubBackgroundView.snp.makeConstraints { const in
            
            const.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(175)
            const.trailing.leading.equalTo(view)
            const.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            
        }
        
        menuClose.snp.makeConstraints { const in
            
            const.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            const.height.width.equalTo(20)
            const.trailing.equalTo(view).offset(-10)
            
       }
        mainLogo.snp.makeConstraints { const in
            
            const.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            const.centerX.equalTo(view)
            
        }
        bottomLabel.snp.makeConstraints { const in
            
            const.bottom.equalTo(menuSubBackgroundView.snp.bottom).offset(-15)
            const.leading.trailing.equalTo(menuSubBackgroundView)
            
        }
        deviderBottom.snp.makeConstraints { const in
            
            const.height.equalTo(1)
            const.bottom.equalTo(bottomLabel.snp.top).offset(-25)
            const.width.equalTo(menuSubBackgroundView.snp.width).inset(40)
            const.centerX.equalTo(menuSubBackgroundView.snp.centerX)
        }
      
        scrollView.snp.makeConstraints { const in
            const.top.equalTo(menuSubBackgroundView.snp.top).offset(25)
            const.centerX.equalTo(menuSubBackgroundView.snp.centerX)
            const.width.equalTo(menuSubBackgroundView.snp.width).inset(40)
            const.bottom.equalTo(deviderBottom.snp.top).inset(-20)

        }
        vStack.snp.makeConstraints { const in

            const.top.equalTo(scrollView.snp.top)
            const.centerX.equalTo(scrollView.snp.centerX)
            const.bottom.equalTo(scrollView.snp.bottom)
            const.width.equalTo(scrollView.snp.width)


        }
        devider.snp.makeConstraints { const in

            const.height.equalTo(1)



        }
       
        
    }
    @objc func closeMenu(sender : UIButton){
     
        self.sideMenuController?.hideRightView(animated: true)
    }
    @objc func openContactUs(sender : UIButton){
       
        
    }
    @objc func openAboutUs(sender : UIButton){
        
      
    }
   
    
}
