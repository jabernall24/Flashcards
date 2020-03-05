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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        print("Did tap")
    }
    
}
