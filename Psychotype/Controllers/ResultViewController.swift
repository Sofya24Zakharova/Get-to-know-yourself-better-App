//
//  ResultViewController.swift
//  Psychotype
//
//  Created by mac on 30.12.2020.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
 
    @IBOutlet weak var descriptionView: UIView!
    
    
    var results = [Answer]()
    
    var testName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionView.layer.cornerRadius = descriptionView.layer.frame.size.height / 3
        navigationItem.hidesBackButton = true
        
        if results.isEmpty{
            setupEmpty()
        } else {
            updateResult()
        }
        
    }
    
 private  func updateResult() {
        var frequencyOfPsychotypes : [Type : Int] = [:]
        let types = results.map {$0.type}
        print(types)
        
        for type in types {
            frequencyOfPsychotypes[type] = (frequencyOfPsychotypes[type] ?? 0) + 1
        }
        
        let sortedFrequensy = frequencyOfPsychotypes.max { $0.value < $1.value }
       // print(sortedFrequensy)
        guard let mostFrequecyType = sortedFrequensy?.key else {return}
        print(mostFrequecyType)
        updateUI(with: mostFrequecyType)
        CoreDataManager.shared.saveResult(with: mostFrequecyType, testName: testName!)
        
    }
    
   private func updateUI(with type: Type){
        typeLabel.text = type.rawValue
        descriptionLabel.text = type.description
    }
    
    
    private func setupEmpty() {
        typeLabel.text = "Вы отвечали на вопросы нечестно"
        descriptionLabel.text = "Пройдите тест занаво"
    }
    
}
