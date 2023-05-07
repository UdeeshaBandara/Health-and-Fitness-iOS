//
//  HeaderCell.swift
//  healthandfitness
//
//  Created by Udeesha Induras on 2023-05-08.
//

import Foundation
import UIKit
import SnapKit

class HeaderCell: UITableViewHeaderFooterView {
    let title: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Roboto-MediumItalic", size: 18)
        lbl.textAlignment = .left
        lbl.textColor = .black
        
        return lbl
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        
        
        contentView.addSubview(title)
        
        
        title.snp.makeConstraints { const in
            
            const.centerY.equalTo(contentView.snp.centerY).offset(5)
            const.leading.equalTo(contentView.snp.leading).offset(20)
            
            
            
        }
    }
}

