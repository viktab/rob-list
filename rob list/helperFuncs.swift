//
//  helperFuncs.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/31/23.
//

import Foundation

func getSuggestions(_ input: String, _ options: [String]) -> [String] {
    var suggestions: [String] = [""]
    for option in options {
        if option.lowercased().hasPrefix(input.lowercased()) {
            suggestions.append(option)
        }
    }
    return suggestions
}
