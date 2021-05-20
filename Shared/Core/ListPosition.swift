//
//  ListPosition.swift
//  bootswiftui
//
//  Created by Robert Sandru on 20.05.2021.
//

import Foundation

enum ListPosition {
    
    case first
    case mid
    case last
    
    case uniqueElement // in case there's a single element in the list.
    case unknown
    
    static func position(in range: Range<Int>, of index: Int) -> ListPosition {
        if range.count == 1 { return .uniqueElement }
        if index == 0 { return .first }
        if index == range.count-1 { return .last }
        
        if range.contains(index) { return .mid }
        
        return .unknown
    }
}
