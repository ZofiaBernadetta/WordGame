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
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = $game.sink { game in
            self.topBarText = game.currentWord.eng
            self.counterText = String(game.currentResult)
            self.updateHeardColors(game: game)
        }
    }
    
    private var timeInterval = 2.0
    var timer: Timer?

    
    @Published private(set) var topBarText: String!
    
    @Published var heartColors: [UIColor] = []
    
    @Published private(set) var counterText: String!
    
    func viewDidAppear() {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: fireTimer)
    }
    
    func reachedBottom(for word: String) -> String {
        game.didntChooseWord(word: word)
    }
    
    func selectedWord(_ word: String) -> String {
        game.selectedWord(word)
    }
    
    private func updateHeardColors(game: Game) {
        let number = game.numberOfLives
        var colors = [UIColor]()
        for index in 1...3 {
            let color = index <= number ? #colorLiteral(red: 0.8, green: 0.2352941176, blue: 0.1843137255, alpha: 1) : #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
            colors.append(color)
        }
        heartColors = colors
    }
    
    @Published var currentFallingText = ""
    
    private func fireTimer(_ timer: Timer) {
        guard
            !game.isGameOver,
            game.currentWords.map(\.spa).count > game.currentIndex
        else {
            self.gameOver()
            return
        }
        currentFallingText = game.currentWords.map(\.spa)[game.currentIndex]
        game.currentIndex += 1
        
    }
    
    private func gameOver() {
        self.timer?.invalidate()
        self.timer = nil
        cancellable?.cancel()
    }
}
