//
//  TestsTableViewCell.swift
//  Psychotype
//
//  Created by mac on 20.01.2021.
//

import UIKit

class TestsTableViewCell: UITableViewCell {

    @IBOutlet weak var testsView: UIView!
    @IBOutlet weak var testNameLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        testsView.layer.cornerRadius = layer.frame.height / 3
    }

    func setupCell(with testName: String){
        testNameLabel.textColor = UIColor.white
        testNameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        testNameLabel.text = testName
        
        if CoreDataManager.shared.checkResult(with: testName){
            //checkMarkImageView.isHidden = false
            checkMarkImageView.image = UIImage(named: "check")
        } else {
            checkMarkImageView.isHidden = true
        }
    }
    override func prepareForReuse() {
        checkMarkImageView.isHidden = false
    }
}


