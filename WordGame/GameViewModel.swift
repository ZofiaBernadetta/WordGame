//
//  GameViewModel.swift
//  WordGame
//
//  Created by Zofia Drabek on 19/07/2020.
//  Copyright © 2020 Zofia Drabek. All rights reserved.
//

import UIKit
import Combine

class GameViewModel: ObservableObject {
    
    @Published var game = Game()
    
    private var timeInterval = 2.0
    var timer: Timer?

    
    var topBarText: String {
        game.currentWord.eng
    }
    
    var heartColors: [UIColor] {
        let number = game.numberOfLives
        var colors = [UIColor]()
        for index in 1...3 {
            let color = index <= number ? #colorLiteral(red: 0.8, green: 0.2352941176, blue: 0.1843137255, alpha: 1) : #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
            colors.append(color)
        }
        return colors
    }
    
    var counterText: String {
        String(game.currentResult)
    }
    
    func viewDidAppear() {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: fireTimer)
    }
    
    
    func reachedBottom(for word: String) -> String {
        game.didntChooseWord(word: word)
    }
    
    func selectedWord(_ word: String) -> String {
        game.selectedWord(word)
    }
    
    @Published var currentFallingText = ""
    
    private func fireTimer(_ timer: Timer) {
        guard game.currentWords.map(\.spa).count > game.currentIndex else {
            self.timer = nil
            return
        }
        currentFallingText = game.currentWords.map(\.spa)[game.currentIndex]
        game.currentIndex += 1
    }
    
}
