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
    var computerCurrentCardValue: Int = 0
    
    var playerCurrentCardString: String = ""
    var playerCurrentCardValue: Int = 0
    
    var playerPile: PlayerPile = PlayerPile()
    var computerPile: PlayerPile = PlayerPile()
    var deck: Deck = Deck()
    
    var score: Int = 0
    
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
            computerPile.addCardsToPile(card: playerCard)
            playerPile.addCardsToPile(card: computerCard)
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
        // Draw card from the deck
        if playerPile.isEmpty() || computerPile.isEmpty()
        {
            finishGame()
        }
        else
        {
            // Player shows a card from there pile
            let playerCardDrawn = playerPile.playTopCard()
            
            // Create string from the card drawn. If value and/or type are not set then exit the function early
            guard let pValue = playerCardDrawn?.value else { return }
            guard let pType = playerCardDrawn?.type else { return }
            
            // Update the current card displayed
            playerCurrentCardString = String.getCardString(value: pValue, type: pType)
            
            // Update the current value for player
            playerCurrentCardValue = pValue
            
            // Now get computer to draw a card
            let computerCardDrawn = computerPile.playTopCard()
            
            // Create string from the card drawn. If value and/or type are not set then exit the function early
            guard let cValue = computerCardDrawn?.value else { return }
            guard let cType = computerCardDrawn?.type else { return }
            
            // Update the current card displayed
            computerCurrentCardString = String.getCardString(value: cValue, type: cType)
            
            // Update the current value for computer
            computerCurrentCardValue = cValue
            
            updateCardImage()
            
            if computerCurrentCardValue == playerCurrentCardValue
            {
                timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(computerSnap), userInfo: false, repeats: false)
            }
        }
    }
    
    // Function executed when the snap button has been pressed
    @IBAction func snapButtonPressed()
    {
        // Increment score if value of the previous card is equal to the value of the current card
        if playerCurrentCardValue == computerCurrentCardValue
        {
            score += 1
            playerPile.addCardsToPile(cards: computerPile.cardsPlayed)
            playerPile.addCardsToPile(cards: playerPile.cardsPlayed)
            
            computerPile.clearPlayedCards()
            playerPile.clearPlayedCards()
            playerPile.reshuffle()
        }
        else
        {
            score -= 1
        }
        
        playerCurrentCardValue = -1
        computerCurrentCardValue = 1
        updateScore()
        playerCardImage?.image = nil
        computerCardImage?.image = nil
    }
    
    // Snap function called for computer player when timer reaches zero
    @objc func computerSnap()
    {
        timer?.invalidate()
        timer = nil
        score -= 1
        computerPile.addCardsToPile(cards: computerPile.cardsPlayed)
        computerPile.addCardsToPile(cards: playerPile.cardsPlayed)
        
        playerPile.clearPlayedCards()
        computerPile.clearPlayedCards()
        computerPile.reshuffle()
        
        playerCurrentCardValue = -1
        computerCurrentCardValue = 1
        updateScore()
        playerCardImage?.image = nil
        computerCardImage?.image = nil
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
            computerPile.addCardsToPile(card: playerCard)
            playerPile.addCardsToPile(card: computerCard)
        }
        updateScore()
        playerCardImage?.image = nil
        computerCardImage?.image = nil
    }
}

