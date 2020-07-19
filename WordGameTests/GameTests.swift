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
    
    
}
