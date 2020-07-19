//
//  ViewController.swift
//  WordGame
//
//  Created by Zofia Drabek on 19/07/2020.
//  Copyright © 2020 Zofia Drabek. All rights reserved.
//

import UIKit
import Combine

class GameViewController:  UIViewController {
    
    var viewModel: GameViewModel!
    
    let topBarColor = #colorLiteral(red: 0.01176470588, green: 0.2, blue: 0.09803921569, alpha: 1)
    let hearts = [UIImageView(), UIImageView(), UIImageView()]
    let topBarTextLabel = UILabel()
    let topBarCounterLabel = UILabel()
    
    let barrier = UIView()
    
    var animator: UIDynamicAnimator!
    var pushBehaviour: UIPushBehavior!
    var gravityBehaviour: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var buttonBehavior: UIDynamicItemBehavior!
    
    var cancellable: AnyCancellable!
    var cancellableForFalling: AnyCancellable!


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GameViewModel()
        
        for heart in hearts {
            heart.image = UIImage(named: "heart")
        }
        
    
        setUpTopBar()
                
        topBarCounterLabel.textColor = .white
        
        view.addSubview(barrier)
        barrier.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 20)
        
        buttonBehavior = UIDynamicItemBehavior()
        buttonBehavior.resistance = 3
        buttonBehavior.friction = 2
        buttonBehavior.allowsRotation = false
        
        animator = UIDynamicAnimator(referenceView: view)
        gravityBehaviour = UIGravityBehavior()
        gravityBehaviour.magnitude = 0.03
        
        pushBehaviour = UIPushBehavior(items: [], mode: .continuous)
        pushBehaviour.pushDirection = .init(dx: 0, dy: 5)
        
        collision = UICollisionBehavior(items: [barrier])
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionDelegate = self
        
        cancellable = viewModel.$game
            .sink { _ in self.updateView() }
        
        cancellableForFalling = viewModel.$currentFallingText
            .sink(receiveValue: { text in
                self.createNewFallingButton(with: text)
            })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
        
        animator.addBehavior(collision)
        animator.addBehavior(buttonBehavior)
        animator.addBehavior(pushBehaviour)
        pushBehaviour.active = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cancellable.cancel()
    }
    
    
    func updateView() {
        
        self.topBarTextLabel.text = self.viewModel.topBarText
        
        self.topBarCounterLabel.text = self.viewModel.counterText
        
        let colors = self.viewModel.heartColors
        for index in 0...2 {
            self.hearts[index].tintColor = colors[index]
        }
    }
    
    
    func createNewFallingButton(with text: String) {
        
        let newButton = UIButton()
        newButton.frame = CGRect(x: 0, y: 141, width: view.bounds.size.width, height: 44)
        newButton.setTitle(text, for: .normal)
        newButton.setTitleColor(self.topBarColor, for: .normal)
        newButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        
        self.view.addSubview(newButton)
        
        self.buttonBehavior.addItem(newButton)
        self.collision.addItem(newButton)
        self.pushBehaviour.addItem(newButton)
    }
    
    @objc func didTapButton(_ button: UIButton) {
        guard let word = button.titleLabel?.text else { return }
        let text = viewModel.selectedWord(word)
        if text != "" {
            displayChangeOfResult(text: text)
        }
    }
    
    func displayChangeOfResult(text: String) {
        
        let myString = text
        var myAttribute = [NSAttributedString.Key : UIColor]()
            if text == "+1" {
                myAttribute = [ NSAttributedString.Key.foregroundColor: .blue ]
            } else if text == "-1" {
                myAttribute = [ NSAttributedString.Key.foregroundColor: .red ]
            } else if text  == "game over" {
                myAttribute = [ NSAttributedString.Key.foregroundColor: .red ]
            }
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        
        let label = UILabel(frame: CGRect(x: 0, y: 60, width: view.bounds.width, height: 20))
        label.attributedText = myAttrString
        view.addSubview(label)
        
        UIView.animate(withDuration: 1.5, animations: {
            label.alpha = 0
        }, completion: { finished in
            label.removeFromSuperview()
        })

    }
    
    private func setUpTopBar() {
        let topBar = UIView()
        view.addSubview(topBar)
        
        topBar.backgroundColor = topBarColor
        
        topBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 141)
        ])
        
        topBar.addSubview(topBarTextLabel)
        topBarTextLabel.translatesAutoresizingMaskIntoConstraints = false
        topBarTextLabel.textColor = .white
        topBarTextLabel.font = UIFont.systemFont(ofSize: 39)
        
        
        NSLayoutConstraint.activate([
            topBarTextLabel.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -8),
            topBarTextLabel.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 16)
        ])
        
        
        let stackView = UIStackView(
            arrangedSubviews: hearts)
        topBar.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -8),
            stackView.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -16)
        ])
        
        topBar.addSubview(topBarCounterLabel)
        topBarCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topBarCounterLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -8),
            topBarCounterLabel.trailingAnchor.constraint(equalTo: topBar.trailingAnchor, constant: -16)
        ])
        
        
    }
    
}

extension GameViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(
        _ behavior: UICollisionBehavior,
        beganContactFor item1: UIDynamicItem,
        with item2: UIDynamicItem,
        at p: CGPoint
    ) {
        guard let button = item2 as? UIButton, let word = button.currentTitle else { return }
        let text = viewModel.reachedBottom(for: word)
        if text != "" {
            displayChangeOfResult(text: text)
        }
        
        gravityBehaviour.removeItem(item2)
        collision.removeItem(item2)
        (item2 as? UIButton)?.removeFromSuperview()
    }
}
