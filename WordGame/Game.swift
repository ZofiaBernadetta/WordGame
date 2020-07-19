//
//  Game.swift
//  WordGame
//
//  Created by Zofia Drabek on 19/07/2020.
//  Copyright © 2020 Zofia Drabek. All rights reserved.
//

import Foundation

struct Game {
    var currentResult = 0
    var numberOfLives = 3
    
    var allWords: [Word] = {
        Bundle.main.decode([Word].self, from: "words.json")
    }()
    
    var currentWord = Word(eng: "", spa: "")
    var currentWords = [Word]()
    var currentIndex = 0
        
    init() {
        beginRound()
    }
    
    mutating func beginRound() {
        currentIndex = 0
        let previousWord = currentWord
        var newWord: Word
        repeat {
            newWord = allWords.randomElement()!
        } while previousWord == newWord
        
        var newWords = [Word]()
        for _ in 0...7 {
            var newWord: Word
            repeat {
                newWord = allWords.randomElement()!
            } while newWords.contains(newWord) || newWord == currentWord
            newWords.append(newWord)
        }
        
        
        newWords.append(newWord)
        newWords.shuffle()
        
        currentWords = newWords
        currentWord = newWord
    }
    
    mutating func didntChooseWord(word: String) -> String {
        if word == currentWord.spa {
            let text = receivedWongAnswear()
            beginRound()
            return text
        } else {
            return ""
        }
    }
    
    mutating func selectedWord(_ word: String) -> String {
        if word == currentWord.spa {
            return receivedGoodAnswear()
        } else {
            return receivedWongAnswear()
        }
    }
    
    private mutating func receivedWongAnswear() -> String {
        currentResult -= 1
        numberOfLives -= 1
        
        if numberOfLives < 1 {
            return "game over"
        } else {
            return "-1"
        }
    }
    private mutating func receivedGoodAnswear() -> String {
        currentResult += 1
        return "+1"
    }
}
