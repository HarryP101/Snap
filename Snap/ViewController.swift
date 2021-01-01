//
//  ViewController.swift
//  Snap
//
//  Created by Harry Prudden on 01/01/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardImage:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func updateCardImage()
    {
        cardImage?.image = UIImage(named: "8H")
    }
    
    @IBAction func drawButtonPressed()
    {
        updateCardImage()
    }
    
    @IBAction func snapButtonPressed()
    {
        // Check for matching card
    }
}

