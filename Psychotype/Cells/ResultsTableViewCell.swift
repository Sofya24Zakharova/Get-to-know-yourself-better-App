//
//  ResultsTableViewCell.swift
//  Psychotype
//
//  Created by mac on 19.01.2021.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var testNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = layer.frame.height / 5
    }

    
    func setupEmptyCell() {
        testNameLabel.text = "Результатов тестов пока нет"
        typeLabel.text = "Пройдите тест"
        
    }
    
    func setupResult(with result: Result) {
        testNameLabel.text = result.testName
        typeLabel.text = "Результат: \(result.type ?? "Нет результата")"
    }

}
