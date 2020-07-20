//
//  GameTests.swift
//  WordGameTests
//
//  Created by Zofia Drabek on 19/07/2020.
//  Copyright © 2020 Zofia Drabek. All rights reserved.
//

import XCTest
@testable import WordGame

class GameTests: XCTestCase {

    var game: Game!
    
    override func setUp() {
        super.setUp()
        game = Game()
    }
    
    func testAllWords() {
        XCTAssertEqual(game.allWords.count, 297)
    }
    
    func testDidntChooseWord() {
        let word = game.currentWord.spa
        
        let currentResult = game.currentResult
        let lives = game.numberOfLives
        let text = game.didntChooseWord(word: word)
        
        XCTAssertEqual(text, "-1")
        XCTAssertEqual(currentResult - 1, game.currentResult)
        XCTAssertEqual(lives - 1, game.numberOfLives)
        
        let newWord = game.currentWord.spa
        let differentWord: String = {
            var word = ""
            repeat {
                word = game.allWords.randomElement()?.spa ?? ""
            } while word == newWord
            return word
        }()
        
        let lives1 = game.numberOfLives
        let currentResult1 = game.currentResult
        let newText = game.didntChooseWord(word: differentWord)
        
        XCTAssertEqual(newText, "")
        XCTAssertEqual(lives1, game.numberOfLives)
        XCTAssertEqual(currentResult1, game.currentResult)
        
        let newWord1 = game.currentWord.spa
        _ = game.didntChooseWord(word: newWord1)
        let newWord2 = game.currentWord.spa
        let newText2 = game.didntChooseWord(word: newWord2)
        print(game.numberOfLives)
        
        XCTAssertEqual(newText2, "game over")
    }
    
    func testSelectedWord() {
        let word = game.currentWord.spa
        
        let currentResult = game.currentResult
        let lives = game.numberOfLives
        let text = game.selectedWord(word)
        
        XCTAssertEqual(text, "+1")
        XCTAssertEqual(currentResult + 1, game.currentResult)
        XCTAssertEqual(lives, game.numberOfLives)
        
        let newWord = game.currentWord.spa
        let differentWord: String = {
            var word = ""
            repeat {
                word = game.allWords.randomElement()?.spa ?? ""
            } while word == newWord
            return word
        }()
        
        let lives1 = game.numberOfLives
        let currentResult1 = game.currentResult
        let newText = game.selectedWord(differentWord)
        
        XCTAssertEqual(newText, "-1")
        XCTAssertEqual(lives1 - 1, game.numberOfLives)
        XCTAssertEqual(currentResult1 - 1, game.currentResult)
    }
}
