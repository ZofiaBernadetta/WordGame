//
//  ViewController.swift
//  WordGame
//
//  Created by Zofia Drabek on 19/07/2020.
//  Copyright © 2020 Zofia Drabek. All rights reserved.
//

import UIKit

class GameViewController:  UIViewController {
    let button = UIButton()
    let topBarColor = #colorLiteral(red: 0.01176470588, green: 0.2, blue: 0.09803921569, alpha: 1)
    let heartImageView1 = UIImageView()
    let heartImageView2 = UIImageView()
    let heartImageView3 = UIImageView()
    let topBarTextLabel = UILabel()
    let topBarCounterLabel = UILabel()
    
    let barrier = UIView()
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTopBar()
        button.frame = CGRect(x: 10, y: 141, width: 200, height: 44)
        button.setTitle("pomodoro", for: .normal)
        view.addSubview(button)
        button.setTitleColor(topBarColor, for: .normal)
        
        topBarTextLabel.text = "tomato"
        heartImageView1.image = UIImage(named: "heart")
        heartImageView2.image = UIImage(named: "heart")
        heartImageView3.image = UIImage(named: "heart")
        
        topBarCounterLabel.text = "10"
        topBarCounterLabel.textColor = .white
        
        let xPosition = (view.bounds.size.width - button.bounds.width) / 2
        button.frame.origin = CGPoint(x: xPosition, y: 141)
        
        view.addSubview(barrier)
        barrier.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 20)
        print(barrier)
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [button])
        gravity.magnitude = 0.5
        
        collision = UICollisionBehavior(items: [button, barrier])
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
    }
    
    override func viewDidLayoutSubviews() {
        let xPosition = (view.bounds.size.width - button.bounds.width) / 2
        button.frame.origin = CGPoint(x: xPosition, y: 141)
        
        barrier.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 20)
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
            arrangedSubviews: [
                heartImageView1,
                heartImageView2,
                heartImageView3,
            ])
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
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        print("bum")
        print(item2)
        print(item1)
    }
}
