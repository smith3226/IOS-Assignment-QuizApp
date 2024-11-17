//
//  ScoreViewController.swift
//  Quiz App
//
//  Created by Blith Correia on 2024-11-15.
//

import Foundation
import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!

 
    var finalScore: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Display the score when the score screen is shown
        if let score = finalScore {
            scoreLabel.text = "Your Score: \(score)"
        }
    }
    
   
    
    
}

