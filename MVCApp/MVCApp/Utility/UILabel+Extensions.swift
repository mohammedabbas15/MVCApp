//
//  UILabel+Extensions.swift
//  MVCApp
//
//  Created by iAskedYou2nd on 7/1/21.
//

import UIKit

extension UILabel {
    
    convenience init(numLine: Int) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = numLine
        self.textAlignment = .right
    }
    
    
}
