//
//  ViewController.swift
//  PokemonAPIDemo
//
//  Created by 後藤孝輔 on 2021/09/15.
///

import UIKit

class ViewController: UIViewController {
    
    var questionLabel: UILabel!
    var imageView: UIImageView!
    var answerLabel: UILabel!
    var textField: UITextField!
    var answerButton: UIButton!
    var pokeManager: PokeManager!
    var quiz: QuizModel!
    var quizManager: QuizManager!
    
    var answer: String = ""
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeManager = PokeManager()
        quizManager = QuizManager()
        quiz = QuizModel()
        pokeManager.delegate = self
        quizManager.delegate = self

        pokeManager.featchPokeData()
        configureUI()
    }
    
    func configureUI() {
        
        let firstView = FirstView()
        firstView.translatesAutoresizingMaskIntoConstraints = false
        questionLabel = firstView.questionLabel
        imageView = firstView.imageView
        answerLabel = firstView.answerLabel
        textField = firstView.inputTextField
        answerButton = firstView.answerButton
        
        view.addSubview(firstView)
        
        [
            firstView.topAnchor.constraint(equalTo: view.topAnchor),
            firstView.leftAnchor.constraint(equalTo: view.leftAnchor),
            firstView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            firstView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ].forEach { $0.isActive = true }
        
        textField.delegate = self
        answerButton.addTarget(self, action: #selector(answerPressed(_:)), for: .touchUpInside)
    }
    
    @objc func answerPressed(_ sender: UIButton) {
        guard let text = textField.text else { return }
        quizManager.judge(answer: quiz.answer, input: text)
    }
    
    func getImageByUrl(url: String) -> UIImage{
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }

}
// MARK: - UITextFieldDelegate Methods
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.endEditing(true)
        guard let text = textField.text else { return }
        self.answer = text
    }
}

// MARK: - PokeManagerDelegate Methods
extension ViewController: PokeManagerDelegate {
    func didFeatchPokeVattle(_ pokeManager: PokeManager, image: String) {
        DispatchQueue.main.async {
            self.imageView.image = self.getImageByUrl(url: image)
        }
    }
    
    func didFeatchPoke(_ pokeManager: PokeManager, name: String, number: Int) {
        quiz.question = "図鑑No.\(number)のポケモンは？"
        quiz.answer = name
        print(name)
        
        DispatchQueue.main.async {
            self.questionLabel.text = self.quiz.question
            self.pokeManager.featchPokeVattleData(name: self.quiz.answer)
        }
    }
}

// MARK: - QuizManagerDelegate Methods
extension ViewController: QuizManagerDelegate {
    func didJudgeCorrect(_ quizManager: QuizManager) {
        DispatchQueue.main.async {
            self.answerLabel.text = "正解！"
        }
        pokeManager.featchPokeData()
        pokeManager.featchPokeVattleData(name: quiz.answer)
    }
    
    func didJudgeIncorrect(_ quizManager: QuizManager) {
        DispatchQueue.main.async {
            self.answerLabel.text = "不正解"
        }
    }
    
}
