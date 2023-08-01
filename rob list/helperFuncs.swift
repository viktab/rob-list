//
//  helperFuncs.swift
//  rob list
//
//  Created by Viktoriya Tabunshchyk on 7/31/23.
//

import Foundation

func getSuggestions(_ input: String, _ options: [String], _ ignore: [String]) -> [String] {
    var suggestions: [String] = [""]
    let ignoreLower = ignore.map {
        $0.lowercased()
    }
    for option in options {
        if option.lowercased().hasPrefix(input.lowercased()) {
            if (!ignoreLower.contains(option.lowercased())) {
                suggestions.append(option)
            }
        }
    }
    return suggestions
}
