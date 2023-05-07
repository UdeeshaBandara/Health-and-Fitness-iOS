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
        self.layer.backgroundColor = #colorLiteral(red: 0.1333574951, green: 0.1360867321, blue: 0.1390593946, alpha: 0.07)
        self.layer.cornerRadius = 5
        self.textColor = #colorLiteral(red: 0.2313431799, green: 0.2313894629, blue: 0.2313401997, alpha: 1)
        self.autocorrectionType = .yes
        self.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        
    }
    
    
}
