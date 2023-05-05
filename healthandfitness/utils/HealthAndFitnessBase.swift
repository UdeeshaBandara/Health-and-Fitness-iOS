//
//  HealthAndFitnessBase.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-05.
//

import Foundation
import UIKit

class HealthAndFitnessBase{
    
    
    
    
}

extension UITextField {
    
    func updateDesign()  {
       
        self.font = UIFont(name: "Roboto-Regular", size: 16)
        self.textAlignment = .left
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.backgroundColor = #colorLiteral(red: 0.4876511097, green: 0.4954020977, blue: 0.5005909204, alpha: 0.09863927983)
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 5
        self.textColor = #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)
        self.autocorrectionType = .yes
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        
    }
    
    
}
