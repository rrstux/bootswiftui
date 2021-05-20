//
//  AlertMock.swift
//  bootswiftui
//
//  Created by Robert Sandru on 19.05.2021.
//

import SwiftUI

struct MockData {
    
    struct Alert_RomanianDisaster {
        static let title: String = "Alert, Romanians!"
        static let description: String = "Omg! An UFO was detected flying above Europe. " +
            "To be more specific: Timisoara, Romania. " +
            "Wild Romanians tried to catch it " +
            "screaing: 'Look! Flying fer!'"
    }
    
    struct Acordion_FAQ {
        struct FaqDataType {
            var question: String
            var answer: String
        }
        static let list: [FaqDataType] = [
            .init(question: "Who is The Doge Father?", answer: "Acording to Twitter, Elon Musk."),
            .init(question: "Should I sell my DOGE?", answer: "No, HODL! Dogecoin is going to the moon. Don't you have that FOMO feeling? Well, please take care and don't sell."),
            .init(question: "First dog to the Moon?", answer: "Well, you know better. "),
            .init(question: "Should I invest in crypto?", answer: "No, not at all. It's addictive. Once you go black, you never go back. Just read some sad stories about people living on the streets because of crypto.")
        ]
    }
}
