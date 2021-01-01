//
//  Card.swift
//  Snap
//
//  Created by Harry Prudden on 01/01/2021.
//

import Foundation

enum CardType : CaseIterable
{
    case D
    case H
    case S
    case C
}

class Card
{
    var value: Int
    var type: CardType
    
    init(value: Int, type: CardType)
    {
        self.value = value
        self.type = type
    }
}
