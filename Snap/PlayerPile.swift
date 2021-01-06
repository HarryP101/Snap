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
    
    func addCardsToPile(card: Card)
    {
        cardsInPile.append(card)
        nCardsInPile += 1
    }
    
    func addCardsToPile(cards: [Card])
    {
        cardsInPile.append(contentsOf: cards)
        nCardsInPile += cards.count
    }
    
    func playTopCard() -> Card?
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
    
    func isEmpty() -> Bool
    {
        return cardsInPile.isEmpty
    }
    
    
    // Reshuffle the current players pile of cards
    func reshuffle()
    {
        cardsInPile.shuffle()
    }
    
    // Add players cards that they won to their own pile + plus their own that they played
    func wonSnap(cardsWon: [Card])
    {
        let totalCardsWon = cardsWon + cardsPlayed
        addCardsToPile(cards: totalCardsWon)
        clearPlayedCards()
    }
    
    // Clears the current array of played cards
    private func clearPlayedCards()
    {
        cardsPlayed.removeAll()
    }
}
