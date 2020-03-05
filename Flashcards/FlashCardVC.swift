//
//  FlashCardVC.swift
//  Flashcards
//
//  Created by Jesus Andres Bernal Lopez on 3/5/20.
//  Copyright © 2020 Jesus Bernal Lopez. All rights reserved.
//

import UIKit
import AudioToolbox

class FlashCardVC: UIViewController {
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var optionButtons: [UIButton]!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var flashcards: [Flashcard] = []
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLabels()
        
        getSavedFlashcards()
        
        if flashcards.count == 0 {
            let flashcard = Flashcard(question: "What is the capital of Brazil?", answer: "Brasilia", option1: "Sao Paulo", option2: "Rio de Janeiro", option3: "Porto Alegre")
            updateFlashcards(with: flashcard, on: -1)
        } else {
            updateLabels()
            updateNextAndPrevButtons()
        }
    }
    
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        questionLabel.isHidden = !questionLabel.isHidden
    }
    
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex -= 1
        updateLabels()
        updateNextAndPrevButtons()
        questionLabel.isHidden = false
        updateButtons()
    }
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex += 1
        updateLabels()
        updateNextAndPrevButtons()
        questionLabel.isHidden = false
        updateButtons()
    }
    
    
    @IBAction func onDidTapOption(_ sender: UIButton) {
        if sender.title(for: .normal) == flashcards[currentIndex].answer {
            UIView.animate(withDuration: 0.25) {
                sender.backgroundColor = .systemYellow
                self.questionLabel.isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                sender.backgroundColor = .systemRed
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
    }
    
    
    func updateFlashcards(with flashcard: Flashcard, on index: Int) {
        if index == -1 {
            flashcards.append(flashcard)
        } else {
            flashcards[index] = flashcard
        }
        
        saveFlashcardsToDisk()
        currentIndex = flashcards.count - 1
        updateLabels()
        updateNextAndPrevButtons()
    }
    
    
    
    @IBAction func onDidTapDelete(_ sender: Any) {
        let alertVC = UIAlertController(title: "Are you sure you want to delete this flashcard?", message: "This action cannot be undone", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes, delete!", style: .destructive) { action in
            self.flashcards.remove(at: self.currentIndex)
            self.currentIndex -= 1
            self.saveFlashcardsToDisk()
            self.updateLabels()
            self.updateNextAndPrevButtons()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel)
        
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        
        present(alertVC, animated: true)
    }
    
    @IBAction func onDidTapEdit(_ sender: Any) {
    }
    
    
    func saveFlashcardsToDisk() {
        let dictionaryArray = flashcards.map({ ["question": $0.question, "answer": $0.answer, "option1": $0.option1, "option2": $0.option2, "option3": $0.option3 ] })
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    }
    
    func getSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            flashcards = dictionaryArray.map({ Flashcard(question: $0["question"]!, answer: $0["answer"]!, option1: $0["option1"]!, option2: $0["option2"]!, option3: $0["option3"]!) })
        }
    }
    
    
    func updateButtons() {
        optionButtons.forEach({ $0.backgroundColor = .systemBackground })
    }
    
    
    func updateLabels() {
        let flashcard = flashcards[currentIndex]
        
        questionLabel.text = flashcard.question
        answerLabel.text = flashcard.answer
        
        let buttons = optionButtons.shuffled()
        buttons[0].setTitle(flashcard.answer, for: .normal)
        buttons[1].setTitle(flashcard.option1, for: .normal)
        buttons[2].setTitle(flashcard.option2, for: .normal)
        buttons[3].setTitle(flashcard.option3, for: .normal)
    }
    
    
    func updateNextAndPrevButtons() {
        nextButton.isEnabled = currentIndex != flashcards.count - 1
        prevButton.isEnabled = currentIndex != 0
        
        nextButton.setTitleColor(nextButton.isEnabled ? .systemIndigo : .systemGray, for: .normal)
        prevButton.setTitleColor(prevButton.isEnabled ? .systemIndigo : .systemGray, for: .normal)
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

        if segue.identifier == "onEdit" {
            let flashcard = flashcards[currentIndex]
            creationVC.flashcard = flashcard
            creationVC.index = currentIndex
        }
    }
}
