//
//  CustomAlertController.swift
//  Psychotype
//
//  Created by mac on 22.01.2021.
//

import UIKit

protocol CustomAlertControllerDelegate{
    func didTappedYes(with index: Int)
    func didTappedNo()
}

class CustomAlertController: UIView {

    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var delegate: CustomAlertControllerDelegate?
    
    var indexOfTest : Int?
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.layer.frame.height / 6
        
        yesButton.layer.cornerRadius = yesButton.layer.frame.height / 3
        noButton.layer.cornerRadius = noButton.layer.frame.height / 3
       // yesButton.isSelected = true
        yesButton.setTitleColor(UIColor.green, for: .highlighted)
       // yesButton.set
    }

    @IBAction func yesButtonTapped(_ sender: UIButton) {
        //sender.backgroundColor = .darkGray
       // yesButton.isSelected = true
        guard let index = indexOfTest else {return}
        delegate?.didTappedYes(with: index)
    }
    
    @IBAction func noButtonTapped(_ sender: UIButton) {
        //sender.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        delegate?.didTappedNo()
    }
}
