//
//  ViewController.swift
//  Snap
//
//  Created by Harry Prudden on 01/01/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardImage:UIImageView?
    @IBOutlet weak var scoreLabel:UILabel?
    
    var currentCardString: String = ""
    var currentCardValue: Int = 0
    var previousCardValue: Int = 0
    var deck: Deck = Deck()
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Initialise first card
        let cardDrawn = deck.drawCard()
        guard let value = cardDrawn?.value else { return }
        guard let type = cardDrawn?.type else { return }
        
        currentCardValue = value
        currentCardString = String.getCardString(value: value, type: type)
        updateCardImage()
        updateScore()
    }

    // Update the current card displayed using the card string
    func updateCardImage()
    {
        cardImage?.image = UIImage(named: currentCardString)
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
        if deck.isEmpty()
        {
            finishGame()
        }
        else
        {
            let cardDrawn = deck.drawCard()
            
            // Create string from the card drawn. If value and/or type are not set then exit the function early
            guard let value = cardDrawn?.value else { return }
            guard let type = cardDrawn?.type else { return }
            
            // Set previous card from current card displayed
            previousCardValue = currentCardValue;
            
            // Update the current card displayed
            currentCardString = String.getCardString(value: value, type: type)
            updateCardImage()
        }
    }
    
    // Function executed when the snap button has been pressed
    @IBAction func snapButtonPressed()
    {
        // Increment score if value of the previous card is equal to the value of the current card
        if currentCardValue == previousCardValue
        {
            score += 1
        }
        else
        {
            score -= 1
        }
        updateScore()
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
        let cardDrawn = deck.drawCard()
        guard let value = cardDrawn?.value else { return }
        guard let type = cardDrawn?.type else { return }
        
        currentCardValue = value
        currentCardString = String.getCardString(value: value, type: type)
        
        updateCardImage()
        updateScore()
    }
}

