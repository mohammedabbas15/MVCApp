//
//  UIView+Extensions.swift
//  MVCApp
//
//  Created by iAskedYou2nd on 7/1/21.
//

import UIKit

extension UIView {
    
    func bindToSuperView(insets: UIEdgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)) {
        guard let superViewSafeArea = self.superview?.safeAreaLayoutGuide else {
            fatalError("Looks like you forgot to add the view to the view hierarchy! GO BACK!")
        }
        
        self.topAnchor.constraint(equalTo: superViewSafeArea.topAnchor, constant: insets.top).isActive = true
        self.leadingAnchor.constraint(equalTo: superViewSafeArea.leadingAnchor, constant: insets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superViewSafeArea.trailingAnchor, constant: -insets.right).isActive = true
        self.bottomAnchor.constraint(equalTo: superViewSafeArea.bottomAnchor, constant: -insets.bottom).isActive = true
    }
    
}
