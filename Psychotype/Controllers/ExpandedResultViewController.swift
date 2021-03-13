//
//  ExpandedResultViewController.swift
//  Psychotype
//
//  Created by mac on 22.01.2021.
//

import UIKit

class ExpandedResultViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    var result : Result?

    override func viewDidLoad() {
        super.viewDidLoad()
        typeLabel.text = result?.type
        descriptLabel.text = result?.prescription
    }
    

}
