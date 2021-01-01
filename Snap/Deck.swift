//
//  Deck.swift
//  Snap
//
//  Created by Harry Prudden on 01/01/2021.
//

import Foundation

class Deck
{
    var cardsInDeck : [Card] = []
    
    init()
    {
        for cardValue in 2..<15
        {
            for cardType in CardType.allCases
            {
                cardsInDeck.append(Card(value: cardValue, type: cardType))
            }
        }
    }
    
    public func drawCard() -> Card
    {
        let index = Int.random(in: 0..<52)
        let card = cardsInDeck[index]
        return card
    }
}
