//
//  UpdateQuestionsController.swift
//  Quiz App
//
//  Created by Blith Correia on 2024-11-16.
//

import Foundation
import UIKit

class UpdateQuestionsController: UIViewController {
    
    var question: Question?
    
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answer1TextField: UITextField!
    
    @IBOutlet weak var answer2TextField: UITextField!
    
    @IBOutlet weak var answer3TextField: UITextField!
    
    @IBOutlet weak var answer4TextField: UITextField!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
          
            if let question = question {
                questionTextField.text = question.questionText
                answer1TextField.text = question.answers[0].text
                answer2TextField.text = question.answers[1].text
                answer3TextField.text = question.answers[2].text
                answer4TextField.text = question.answers[3].text
            }
        }
        
        // Save the edited question and answers
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let question = question else { return }
        
        // Update the question and its answers with the new text
        question.questionText = questionTextField.text ?? ""
        question.answers[0].text = answer1TextField.text ?? ""
        question.answers[1].text = answer2TextField.text ?? ""
        question.answers[2].text = answer3TextField.text ?? ""
        question.answers[3].text = answer4TextField.text ?? ""
        
        // Mark Answer 1 as correct and the others as incorrect
        question.answers[0].isCorrect = true
        question.answers[1].isCorrect = false
        question.answers[2].isCorrect = false
        question.answers[3].isCorrect = false
        
        // Show an alert to confirm that the question was updated
        let alert = UIAlertController(title: "Success", message: "Question updated successfully.", preferredStyle: .alert)
        
        // Add an OK action to dismiss the alert
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        
        // Present the alert
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Cancel", message: "Are you sure you want to cancel?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.dismiss(animated: true, completion: nil)  // Dismiss the screen without saving
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))  // Do nothing
        
        present(alert, animated: true)
    }

    // Helper method to show alerts
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
      
    

    
}
