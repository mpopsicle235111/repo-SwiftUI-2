//
//  BottomBarItem.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//


import SwiftUI

public struct BottomBarItem {
    public let icon: Image
    public let title: String
    public let color: Color
    
    public init(icon: UIImage,
                title: String,
                color: Color){
        self.icon = Image(uiImage: icon)
        self.title = title
        self.color = color
    }
}
