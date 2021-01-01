//
//  ViewController.swift
//  Snap
//
//  Created by Harry Prudden on 01/01/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardImage:UIImageView?
    
    var cardToDisplay: String = ""
    var deck: Deck?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        deck = Deck()
    }

    func updateCardImage()
    {
        cardImage?.image = UIImage(named: cardToDisplay)
    }
    
    @IBAction func drawButtonPressed()
    {
        // Draw card from the deck
        let cardDrawn = deck?.drawCard()
        
        // Create string from the card drawn
        let value = cardDrawn?.value
        let type = cardDrawn?.type
        
        var result = ""
        
        if value ?? 0 > 10
        {
            switch value
            {
            case 11:
                result += "J"
            case 12:
                result += "Q"
            case 13:
                result += "K"
            case 14:
                result += "A"
            default:
                result = ""
            }
        }
        else
        {
            result += "\(value ?? 0)"
        }
        
        result += "\(type ?? CardType.H)"
        
        cardToDisplay = result
        
        updateCardImage()
    }
    
    @IBAction func snapButtonPressed()
    {
        // Check for matching card
    }
}

