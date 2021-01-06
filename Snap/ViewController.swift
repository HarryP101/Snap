//
//  ViewController.swift
//  Snap
//
//  Created by Harry Prudden on 01/01/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerCardImage:UIImageView?
    @IBOutlet weak var computerCardImage:UIImageView?
    @IBOutlet weak var scoreLabel:UILabel?
    
    var computerCurrentCardString: String = ""
    var computerCurrentCardValue: Int = 1
    
    var playerCurrentCardString: String = ""
    var playerCurrentCardValue: Int = -1
    
    var humanPlayerPile: PlayerPile = PlayerPile()
    var computerPlayerPile: PlayerPile = PlayerPile()
    var deck: Deck = Deck()
    
    var score: Int = 0
    var countdown: Int = 2000 // time in milliseconds
    
    // Declare timer for computer snap function
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Initialise player and computer piles
        for _ in 0..<26
        {
            guard let computerCard = deck.drawCard() else { return }
            guard let playerCard = deck.drawCard() else { return }
            computerPlayerPile.addCardsToPile(card: playerCard)
            humanPlayerPile.addCardsToPile(card: computerCard)
        }
        updateCardImage()
        updateScore()
    }

    // Update the current card displayed using the card string
    func updateCardImage()
    {
        computerCardImage?.image = UIImage(named: computerCurrentCardString)
        playerCardImage?.image = UIImage(named: playerCurrentCardString)
    }
    
    // Update the current score
    func updateScore()
    {
        scoreLabel?.text = String(score)
    }
    
    // Function executed when the draw button has been pressed
    @IBAction func drawButtonPressed()
    {
        // Don't do anything if player trys to draw when a SNAP is possible
        guard computerCurrentCardValue != playerCurrentCardValue else { return }
        
        // Draw card from the deck
        if humanPlayerPile.isEmpty() || computerPlayerPile.isEmpty()
        {
            finishGame()
        }
        else
        {
            // TODO: Encapsulate this into a separate function which takes a PlayerPile as a parameter
            // Player shows a card from there pile
            let playerCardDrawn = humanPlayerPile.playTopCard()
            
            // Create string from the card drawn. If value and/or type are not set then exit the function early
            guard let pValue = playerCardDrawn?.value else { return }
            guard let pType = playerCardDrawn?.type else { return }
            
            // Update the current card displayed
            playerCurrentCardString = String.getCardString(value: pValue, type: pType)
            
            // Update the current value for player
            playerCurrentCardValue = pValue
            
            // Now get computer to draw a card
            let computerCardDrawn = computerPlayerPile.playTopCard()
            
            // Create string from the card drawn. If value and/or type are not set then exit the function early
            guard let cValue = computerCardDrawn?.value else { return }
            guard let cType = computerCardDrawn?.type else { return }
            
            // Update the current card displayed
            computerCurrentCardString = String.getCardString(value: cValue, type: cType)
            
            // Update the current value for computer
            computerCurrentCardValue = cValue
            
            // Update the image of the cards drawn
            updateCardImage()
            
            if computerCurrentCardValue == playerCurrentCardValue
            {
                // Check timer hasn't already been started
                guard timer == nil else { return }
                timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(computerSnap), userInfo: false, repeats: true)
            }
        }
    }
    
    // TODO Create a private function which takes a player as a parameter
    // Function executed when the snap button has been pressed
    @IBAction func snapButtonPressed()
    {
        // Increment score if value of the previous card is equal to the value of the current card
        if playerCurrentCardValue == computerCurrentCardValue
        {
            // Increment score
            score += 1
            
            // Add both player and computers cards to the players pile
            humanPlayerPile.wonSnap(cardsWon: computerPlayerPile.cardsPlayed)
            
            // Reshuffle the players deck
            humanPlayerPile.reshuffle()
            
            // Switch off the computers timer
            timer?.invalidate()
            timer = nil
        }
        else
        {
            // User was wrong, so decrement their score
            score -= 1
        }
        
        // Reset current card values so they are opposite (so player cannot repeatedly press SNAP)
        playerCurrentCardValue = -1
        computerCurrentCardValue = 1
        
        // Update score and set the images to nil
        updateScore()
        playerCardImage?.image = nil
        computerCardImage?.image = nil
    }
    
    // Snap function called for computer player when timer reaches zero
    @objc func computerSnap()
    {
        // Decrement the countdown by 1. Timer is set to repeat every 1 ms
        countdown -= 1
        
        // When the countdown reaches zero, ~2 seconds has passed
        if countdown == 0
        {
            // Switch off the computer timer
            timer?.invalidate()
            timer = nil
            
            // Decrement the players score by 1
            score -= 1
            
            // Add player and computers played cards to the computers pile
            computerPlayerPile.wonSnap(cardsWon: computerPlayerPile.cardsPlayed)
            
            // Reshuffle the computers pile
            computerPlayerPile.reshuffle()
            
            // Set the card values to opposite values
            playerCurrentCardValue = -1
            computerCurrentCardValue = 1
            
            // Update score and set both images to nil
            updateScore()
            playerCardImage?.image = nil
            computerCardImage?.image = nil
            
            // Reset countdown back to 2 seconds
            countdown = 2000
        }
    }
    
    // Called when the deck has no more cards remaining
    func finishGame()
    {
        // Display an alert to the user with their score
        let alert = UIAlertController(title: "No more cards!", message: "There are no more cards in the deck! You got a score of \(score) points. Awesome!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK, start new game", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
        
        // Reset score and deck
        score = 0
        deck.reshuffle()
        
        // Initialise player and computer piles
        for _ in 0..<26
        {
            guard let computerCard = deck.drawCard() else { return }
            guard let playerCard = deck.drawCard() else { return }
            computerPlayerPile.addCardsToPile(card: playerCard)
            humanPlayerPile.addCardsToPile(card: computerCard)
        }
        updateScore()
        playerCardImage?.image = nil
        computerCardImage?.image = nil
    }
}

