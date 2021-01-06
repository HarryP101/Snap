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
    var nCardsInDeck : Int = 0
    
    // Initialise deck with 52 cards
    init()
    {
        nCardsInDeck = 52
        for cardValue in 2..<15
        {
            for cardType in CardType.allCases
            {
                cardsInDeck.append(Card(value: cardValue, type: cardType))
            }
        }
    }
    
    // Draw a random card from the deck. Returns nil if no cards are left in the deck
    func drawCard() -> Card?
    {
        if nCardsInDeck > 0
        {
            let index = Int.random(in: 0..<nCardsInDeck)
            let card = cardsInDeck[index]
            cardsInDeck.remove(at: index)
            nCardsInDeck -= 1
            return card
        }
        else
        {
            return nil
        }
    }
    
    // Check whether the deck is empty
    func isEmpty() -> Bool
    {
        return cardsInDeck.isEmpty
    }
    
    // Reshuffle 52 cards into the deck
    func reshuffle()
    {
        cardsInDeck.removeAll()
        nCardsInDeck = 52
        
        for cardValue in 2..<15
        {
            for cardType in CardType.allCases
            {
                cardsInDeck.append(Card(value: cardValue, type: cardType))
            }
        }
    }
}
