//
//  QuestionsViewController.swift
//  Psychotype
//
//  Created by mac on 30.12.2020.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet weak var yesNoStackView: UIStackView!
    @IBOutlet var yesNoButtons: [CustomButton]!
    
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet weak var rangedSlider: UISlider!
    
// MARK: - private properties
    //private let questions = Question.getQuestions()
    var questions = [Question]()
    
    var nameOfTest : String?
    
    private var questionIndex = 0
    
    private var currentAnswers: [Answer] {
       return questions[questionIndex].answers
    }
    
    private var choosenAnswers: [Answer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions.shuffle()
       
        updateUI()
    }
    
    
    // MARK: - @IBActions
    @IBAction func singleAnswersTapped(_ sender: UIButton) {
        
        guard let currentIndexOfButton = singleButtons.firstIndex(of: sender)  else {return}
        
        let choosenAnswer = currentAnswers[currentIndexOfButton]
        choosenAnswers.append(choosenAnswer)
        
        changeQuestion()
        
    }
    
    @IBAction func rangedAnswerTapped(_ sender: UIButton) {
        let index = lroundf(rangedSlider.value * Float(currentAnswers.count - 1))
        print(index)
        let choosenAnswer = currentAnswers[index]
        choosenAnswers.append(choosenAnswer)
        
        changeQuestion()
    }
    
    @IBAction func yesNoAnswerTapped(_ sender: CustomButton) {
        guard let currentIndexOfButton = yesNoButtons.firstIndex(of: sender)  else {return}
        
        if currentIndexOfButton == 0 {
            let choosenAnswer = currentAnswers[currentIndexOfButton]
            choosenAnswers.append(choosenAnswer)
        }

        changeQuestion()
    }
    
}

// MARK: - Work with UI
extension QuestionsViewController{
    
    private func updateUI() {
        for stack in [singleStackView, rangedStackView, yesNoStackView]{
            stack?.isHidden = true
        }
        
        //get and set current question
        
        let curentQuestion = questions[questionIndex]
        questionLabel.text = curentQuestion.text
        
        //calculate progress
        
        let currentProgress = Float(questionIndex) / Float(questions.count)
        progressView.setProgress(currentProgress, animated: true)
        
        title = "Вопрос №\(questionIndex + 1) из \(questions.count)"
        
        showAnswers(for: curentQuestion.type)
    }
    
    
    
    private func showAnswers(for type: ResponceType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswers)
        case .ranged:
            showRangedStackView(with: currentAnswers)
        case .yesNo:
            showYesNoStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        
        for (answer, button) in zip(answers, singleButtons){
            button.setTitle(answer.text, for: .normal)
            button.setTitleColor(.black, for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() ) {
                self.singleStackView.isHidden = false
        }
        
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
        
        rangedStackView.isHidden.toggle()
        
    }
    
    private func showYesNoStackView(with answers: [Answer]) {
      
        for (answer, button) in zip(answers, singleButtons){
            button.setTitle(answer.text, for: .normal)
//button.setTitleColor(.black, for: .normal)
        }
        yesNoStackView.isHidden = false
        
    }
    
    // MARK: - Navigation
    
    func changeQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            let resultVC = segue.destination as! ResultViewController
            resultVC.results = choosenAnswers
            resultVC.testName = nameOfTest
        }
    }

}
