//
//  String.swift
//  Snap
//
//  Created by Harry Prudden on 01/01/2021.
//

import Foundation

extension String
{
    // Generate the string representing a card image, e.g. "H5"
    static func getCardString(value: Int, type: CardType) -> String
    {
        var result: String = ""
        
        if value > 10
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
            result += "\(value)"
        }
        
        result += "\(type)"
        
        return result;
    }
}
