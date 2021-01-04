//
//  PlayerPile.swift
//  Snap
//
//  Created by Harry Prudden on 03/01/2021.
//

import Foundation

class PlayerPile
{
    var cardsInPile: [Card] = []
    var nCardsInPile: Int = 0
    var cardsPlayed: [Card] = []
    
    init()
    {
        
    }
    
    public func addCardsToPile(card: Card)
    {
        cardsInPile.append(card)
        nCardsInPile += 1
    }
    
    public func addCardsToPile(cards: [Card])
    {
        cardsInPile.append(contentsOf: cards)
        nCardsInPile += cards.count
    }
    
    public func playTopCard() -> Card?
    {
        if nCardsInPile > 0
        {
            let index = Int.random(in: 0..<nCardsInPile)
            let card = cardsInPile[index]
            cardsInPile.remove(at: index)
            nCardsInPile -= 1
            
            cardsPlayed.append(card)
            return card
        }
        else
        {
            return nil
        }
    }
    
    public func isEmpty() -> Bool
    {
        return cardsInPile.isEmpty
    }
    
    // Clears the current array of played cards
    public func clearPlayedCards()
    {
        cardsPlayed.removeAll()
    }
    
    // Reshuffle the current players pile of cards
    public func reshuffle()
    {
        cardsInPile.shuffle()
    }
}
