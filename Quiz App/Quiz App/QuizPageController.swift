import Foundation
import UIKit

class QuizPageController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    // Keeping track of the score
    var score = 0
    
    // Track the current question index
    var currentQuestionIndex = 0
    
    // Gettotal number of questions from the shared QuestionManager
    var totalQuestions: Int {
        return QuestionManager.shared.questions.count
    }
    
    var optionButtons: [UIButton] {
        return [option1Button, option2Button, option3Button, option4Button]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion(at: currentQuestionIndex)
    }
    
    // Function to display the question and its options
    func showQuestion(at index: Int) {
        guard index < totalQuestions else { return } // Prevent index out of bounds
        
        let question = QuestionManager.shared.questions[index]
        questionLabel.text = question.questionText  // Set the question text
        
        // Set options for buttons using a for loop
        for i in 0..<min(optionButtons.count, question.answers.count) {
            let button = optionButtons[i]
            let answer = question.answers[i]
            button.setTitle(answer.text, for: .normal)
        }
        
        // Reset answer button colors
        resetAnswerButtons()
        
        // Update progress bar
        updateProgressBar()
        
        // If it is the last question show the submit button
        if index == totalQuestions - 1 {
            submitButton.isHidden = false
        } else {
            submitButton.isHidden = true
        }
    }
    
    // Function to reset all answer buttons to their initial state
    func resetAnswerButtons() {
        optionButtons.forEach { button in
            button.backgroundColor = .clear  // Reset background color
            button.isUserInteractionEnabled = true
        }
    }
    
    // Update progress bar based on the current question index
    func updateProgressBar() {
        progressBar.progress = Float(currentQuestionIndex + 1) / Float(totalQuestions)
    }
    
    // option button is selected
    @IBAction func optionSelected(_ sender: UIButton) {
        guard let selectedAnswerText = sender.titleLabel?.text else { return }
        
        let question = QuestionManager.shared.questions[currentQuestionIndex]
        let isCorrect = isAnswerCorrect(for: question, selectedAnswer: selectedAnswerText)
        
        // Update button color based on whether the answer is correct
        updateButtonColor(for: sender, isCorrect: isCorrect)
        
        // If the answer is correct, increment the score
        if isCorrect {
            score += 1
        }
        
        // Disable all answer buttons to prevent multiple selections
        disableOptionButtons()
    }
    
    // Check if the selected answer is correct for the current question
    func isAnswerCorrect(for question: Question, selectedAnswer: String) -> Bool {
        return question.answers.first { $0.text == selectedAnswer }?.isCorrect ?? false
    }
    
    // Change the button color to green if correct
    func updateButtonColor(for button: UIButton, isCorrect: Bool) {
        button.backgroundColor = isCorrect ? .green : .red
    }
    
    // Disable all option buttons after an answer is selected
    func disableOptionButtons() {
        optionButtons.forEach { $0.isUserInteractionEnabled = false }
    }
    
    // Move to the next question
    @IBAction func nextQuestion(_ sender: UIButton) {
        if currentQuestionIndex < totalQuestions - 1 {
            currentQuestionIndex += 1
            showQuestion(at: currentQuestionIndex)
        } else {
            showScoreScreen()
        }
    }

    // Move to the previous question
    @IBAction func previousQuestion(_ sender: UIButton) {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            showQuestion(at: currentQuestionIndex)  // Show the previous question
        }
    }
    
    // Show the score screen
    func showScoreScreen() {
        performSegue(withIdentifier: "showScore", sender: nil) 
    }
    
    // Prepare for segue to ScoreViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showScore" {
            if let scoreVC = segue.destination as? ScoreViewController {
                scoreVC.finalScore = score 
            }
        }
    }
    
    // Display an alert at the end of the quiz
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

