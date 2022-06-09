//
//  BottomBarItemView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//
// This is a view to display the bottom bar item that has been received here via @Binding

import SwiftUI

public struct BottomBarItemView: View {
    @Binding var selected : Int
    public let index: Int
    public let item: BottomBarItem
    let colorCapsule: Color = Color(UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1))
    
    let mainColorsGradient = [
        Color(UIColor(red: 0.941, green: 0.557, blue: 0.278, alpha: 1)),
        Color(UIColor(red: 0.965, green: 0.396, blue: 0.337, alpha: 1))
    ]
    
    public var body: some View {
        HStack {
                VStack {
                item.icon
                    .imageScale(.medium)
                    .gradientForeground(colors: isSelected ? mainColorsGradient : [.gray])
                
                if isSelected {
                    Text(item.title)
                        .font(.system(size: 11))
                        .fontWeight(.bold)
                        .gradientForeground(colors: mainColorsGradient)
                }
            }
        }
        .padding(11)
        //.padding(.leading)
        .background(
            Capsule()
                .fill(isSelected ? colorCapsule : Color.clear)
        )
    }
    
    var isSelected : Bool {
        selected == index
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors), startPoint: .init(x: 0.25, y: 0.5), endPoint: .init(x: 0.75, y: 0.5))
        )
        //.transformEffect(.init(a: 0.97, b: 0.72, c: -0.72, d: 0.97, tx: 0, ty: 0))
        .mask(self)
    }
}
