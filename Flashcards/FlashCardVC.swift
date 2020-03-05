//
//  FlashCardVC.swift
//  Flashcards
//
//  Created by Jesus Andres Bernal Lopez on 3/5/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit

class FlashCardVC: UIViewController {

    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var optionButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLabels()
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        questionLabel.isHidden = !questionLabel.isHidden
    }
    
    func updateFlashcard(question: String, answer: String) {
        questionLabel.text = question
        answerLabel.text = answer
    }
    
    private func setUpLabels() {
        questionLabel.layer.cornerRadius = 10
        questionLabel.clipsToBounds = true
        
        answerLabel.layer.cornerRadius = 10
        answerLabel.clipsToBounds = true
        
        optionButtons.forEach({
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor.systemIndigo.cgColor
            $0.layer.borderWidth = 2
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let navController = segue.destination as! UINavigationController
        
        let creationVC = navController.topViewController as! CreationVC
        
        creationVC.flashcardVC = self
    }
}
