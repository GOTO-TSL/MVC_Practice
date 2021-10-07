//
//  QuizManager.swift
//  PokemonAPIDemo
//
//  Created by 後藤孝輔 on 2021/10/07.
//

import Foundation

protocol QuizManagerDelegate {
    func didJudgeCorrect(_ quizManager: QuizManager)
    func didJudgeIncorrect(_ quizManager: QuizManager)
}

struct QuizManager {
    
    var delegate: QuizManagerDelegate?
    
    func judge(answer: String, input: String) {
        if answer == input {
            self.delegate?.didJudgeCorrect(self)
        } else {
            self.delegate?.didJudgeIncorrect(self)
        }
    }
}
