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
    
    var currentCard: String = ""
    var previousCard: String = ""
    var deck: Deck?
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialise deck and first card
        deck = Deck()
        
        let cardDrawn = deck?.drawCard()
        guard let value = cardDrawn?.value else { return }
        guard let type = cardDrawn?.type else { return }
        
        currentCard = String.getCardString(value: value, type: type)
        updateCardImage()
        updateScore()
    }

    // Update the current card displayed using the card string
    func updateCardImage()
    {
        cardImage?.image = UIImage(named: currentCard)
    }
    
    // Update the current score
    func updateScore()
    {
        scoreLabel?.text = String(score)
    }
    
    @IBAction func drawButtonPressed()
    {
        // Draw card from the deck
        let cardDrawn = deck?.drawCard()
        
        // Create string from the card drawn. If value and/or type are not set then exit the function early
        guard let value = cardDrawn?.value else { return }
        guard let type = cardDrawn?.type else { return }
        
        // Set previous card from current card displayed
        previousCard = currentCard;
        
        // Update the current card displayed
        currentCard = String.getCardString(value: value, type: type)
        updateCardImage()
    }
    
    @IBAction func snapButtonPressed()
    {
        if currentCard == previousCard
        {
            score += 1
        }
        else
        {
            score -= 1
        }
        updateScore()
    }
}

