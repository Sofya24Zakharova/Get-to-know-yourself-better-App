//
//  CustomButton.swift
//  Psychotype
//
//  Created by mac on 31.12.2020.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
           super.init(coder: coder)
             setupButton()
         }
    
   private func setupButton() {
    backgroundColor = #colorLiteral(red: 0, green: 0.7031856179, blue: 0.7095955014, alpha: 1)
    setTitleColor(.white, for: .normal)
    titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
    layer.cornerRadius = layer.frame.height/2
    titleLabel?.numberOfLines = 0
    titleLabel?.lineBreakMode = .byWordWrapping
    titleLabel?.textAlignment = .center
    sizeToFit()
   }
}
