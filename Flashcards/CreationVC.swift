//
//  CreationVC.swift
//  Flashcards
//
//  Created by Jesus Andres Bernal Lopez on 3/5/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit

class CreationVC: UIViewController {

    var flashcardVC: FlashCardVC!
    @IBOutlet var questionTextField: UITextField!
    @IBOutlet var answerTextField: UITextField!
    @IBOutlet var option1TextField: UITextField!
    @IBOutlet var option2TextField: UITextField!
    @IBOutlet var option3TextField: UITextField!
    
    var flashcard: Flashcard?
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillOutTextFields()
    }
    
    
    func fillOutTextFields() {
        if let flashcard = flashcard {
            questionTextField.text = flashcard.question
            answerTextField.text = flashcard.answer
            option1TextField.text = flashcard.option1
            option2TextField.text = flashcard.option2
            option3TextField.text = flashcard.option3
        }
    }
    
    
    @IBAction func didTapOnDone(_ sender: Any) {
        guard let questionText = questionTextField.text, !questionText.isEmpty,
            let answerText = answerTextField.text, !answerText.isEmpty,
            let option1Text = option1TextField.text, !option1Text.isEmpty,
            let option2Text = option2TextField.text, !option2Text.isEmpty,
            let option3Text = option3TextField.text, !option3Text.isEmpty else {
                presentAlert()
                return
        }
        
        let flashcard = Flashcard(question: questionText, answer: answerText, option1: option1Text, option2: option2Text, option3: option3Text)
        flashcardVC.updateFlashcards(with: flashcard, on: index)
        
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    func presentAlert() {
        let alertVC = UIAlertController(title: "No question or answer", message: "You must provide both a question and an answer", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alertVC.addAction(okAction)
        
        present(alertVC, animated: true)
    }
}
