//
//  BarBuilder.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//

import Foundation

@resultBuilder
public struct BarBuilder{}

public extension BarBuilder{
    
    static func buildBlock(_ items: BottomBarItem...) -> [BottomBarItem] {
        items
    }
}

