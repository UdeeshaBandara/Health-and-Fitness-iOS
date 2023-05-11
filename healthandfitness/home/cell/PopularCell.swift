//
//  PopularCell.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-07.
//

import Foundation
import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import Kingfisher

class PopularCell : UITableViewCell {
    
    let popluarCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    
    var popularExerciseArray : JSON = ""
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(popluarCollection)
        
        setupConstraint()
        homeNetworkRequest ()
        
    }
    
    func setupConstraint(){
        popluarCollection.backgroundColor = .white
        popluarCollection.showsHorizontalScrollIndicator = false
        popluarCollection.dataSource = self
        popluarCollection.delegate = self
        if let layout = popluarCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            
        }
        popluarCollection.register(PopularSubCell.self, forCellWithReuseIdentifier: "popularSubCell")
        
        popluarCollection.snp.makeConstraints { const in
            
            const.edges.equalTo(contentView)
            
            
            
        }
        
    }
    func homeNetworkRequest () {
        
        
        NetworkManager.shared.defaultNetworkRequest(url: HealthAndFitnessBase.BaseURL + "exercise/home", header: ["Authorization":(KeychainWrapper.standard.string(forKey: "accessToken") ?? "")], requestMethod: .get, showIndicator: false, success: { response in
            
            
            if response["status"].boolValue {
                
                self.popularExerciseArray = response["data"]
                self.popluarCollection.reloadData()
                
            }else{
                
                HealthAndFitnessBase.shared.showToastMessage(title: "Home", message: response["data"].stringValue)
                
            }
            
            
            
        }){errorString in
            print(errorString)
            
            HealthAndFitnessBase.shared.showToastMessage(title: "Home", message: "Something went wrong. Please try again")
            
        }
    }
}
extension PopularCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return popularExerciseArray.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularSubCell", for: indexPath) as! PopularSubCell
        
        cell.title.text =  popularExerciseArray[indexPath.row]["name"].stringValue
        cell.backgroundImage.kf.setImage(with: URL(string:   popularExerciseArray[indexPath.row]["coverImageUrl"].stringValue))
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 140)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
    
}

