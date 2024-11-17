import UIKit

class AddQuestionsController: UIViewController {
    
    
    @IBOutlet weak var InputQuestionTextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var FirstIncorrectTextField: UITextField!
    @IBOutlet weak var SecondIncorrectTextField: UITextField!
    @IBOutlet weak var ThirdIncorrectTextField: UITextField!

    // Done button action to save the question
    @IBAction func doneBtn(_ sender: Any) {
        
        // Validate all fields
        guard let questionText = InputQuestionTextField.text, !questionText.isEmpty,
              let correctAnswer = correctAnswerTextField.text, !correctAnswer.isEmpty,
              let wrongAnswer1 = FirstIncorrectTextField.text, !wrongAnswer1.isEmpty,
              let wrongAnswer2 = SecondIncorrectTextField.text, !wrongAnswer2.isEmpty,
              let wrongAnswer3 = ThirdIncorrectTextField.text, !wrongAnswer3.isEmpty else {
            // Show  error if any of the fields are empty
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        // Create the answers for the question
        let answers = [
            Answer(text: correctAnswer, isCorrect: true),
            Answer(text: wrongAnswer1, isCorrect: false),
            Answer(text: wrongAnswer2, isCorrect: false),
            Answer(text: wrongAnswer3, isCorrect: false)
        ]
        
        // Create new Question object
        let newQuestion = Question(questionText: questionText, answers: answers)
        
        //shuffle answers
        newQuestion.shuffleAnswers()
        
        // Add the new question to the QuestionManager
        QuestionManager.shared.addNewQuestion(q: newQuestion)
        
        
        print("Saved Question: \(newQuestion.questionText)")
            for (index, answer) in newQuestion.answers.enumerated() {
                print("Answer \(index + 1): \(answer.text) - Correct: \(answer.isCorrect)")
            }
        
        //show success alert
        showAlert(message: "Question saved successfully!")
        
        //clear input
        clearInput()
        
        
       //go back to previous screen
        dismiss(animated: true, completion: nil)
    }

    // Cancel button action
    @IBAction func cancelButton(_ sender: UIButton) {
        // Show a confirmation alert before canceling
        let alert = UIAlertController(title: "Cancel", message: "Are you sure you want to cancel?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))  
        
        present(alert, animated: true)
    }

    // Helper method to show alerts
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // Method to clear the input fields for the next question
        func clearInput() {
            // Clear all text fields
            InputQuestionTextField.text = ""
            correctAnswerTextField.text = ""
            FirstIncorrectTextField.text = ""
            SecondIncorrectTextField.text = ""
            ThirdIncorrectTextField.text = ""
        }
}

