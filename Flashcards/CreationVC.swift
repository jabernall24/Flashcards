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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        guard let questionText = questionTextField.text, !questionText.isEmpty,
            let answerText = answerTextField.text, !answerText.isEmpty else {
                presentAlert()
                return
        }
        
        flashcardVC.updateFlashcard(question: questionText, answer: answerText)
        
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
