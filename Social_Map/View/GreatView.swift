//
//  GreatView.swift
//  Social_Map
//
//  Created by Dillon Cain on 3/21/19.
//  Copyright © 2019 Cain Computers. All rights reserved.
//

import UIKit

class GreatView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
    }

}
