//
//  DescriptionViewController.swift
//  Psychotype
//
//  Created by mac on 18.01.2021.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var testNameLabel: UILabel!
    @IBOutlet weak var viewForLabel: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var test : Test?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
              self.navigationController?.setNavigationBarHidden(false, animated: animated)
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        let attributes = [
//            NSAttributedString.Key.font : UIFont(name: "AvenirNext-DemiBold", size: 18)]
//
//        navigationController?.navigationBar.largeTitleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(test)
        viewForLabel.layer.cornerRadius = viewForLabel.layer.frame.height / 2
        
        descriptionLabel.text = test?.descriptionOfTest
        testNameLabel.text = test?.nameOfTest
       // title = test?.nameOfTest

    
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
           if segue.identifier == "startTesting"{

            let questionVC = segue.destination as! QuestionsViewController

            questionVC.questions = test!.questions
            questionVC.nameOfTest = test?.nameOfTest
            
    }
    
}

}
