
import Foundation

class Question {
    var questionText: String = ""
    
    var answers: [Answer]
    
    init(questionText: String, answers: [Answer]) {
        self.questionText = questionText
        self.answers = answers
    }
    
    func shuffleAnswers() {
        answers.shuffle()
    }
    
    func isAnswerCorrect(selectedAnswer: Answer) -> Bool {
           return selectedAnswer.isCorrect
    }
}

class Answer {
    var text: String = ""
    var isCorrect: Bool
    
    init(text: String, isCorrect: Bool) {
        self.text = text
        self.isCorrect = isCorrect
    }
}


class QuestionManager {
    public static var shared = QuestionManager()
    
    var questions: [Question] = []
    
    
    func addNewQuestion(q: Question){
        questions.append(q)
    }
    
    func deleteContact(qIndex : Int){
        questions.remove(at: qIndex)
    }
    
    func shuffleAllAnswers() {
        for question in questions {
            question.shuffleAnswers()
        }
    }
}
