//
//  BottomBar.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 05.06.2022.
//
// BottomBar contains a set of BottomBarItems that are set by indexes

import SwiftUI

public struct BottomBar : View {
    @Binding public var selectedIndex: Int
    
    public let items: [BottomBarItem]
    
    public init(selectedIndex: Binding<Int>, items: [BottomBarItem]) {
        self._selectedIndex = selectedIndex
        self.items = items
    }
    
    //    public init(selectedIndex: Binding<Int>, @BarBuilder items: () -> [BottomBarItem]) {
    //        self(selectedIndex: selectedIndex,
    //                       items: items())
    //    }
    //
    //    public init(selectedIndex: Binding<Int>, item: BottomBarItem) {
    //        self(selectedIndex: selectedIndex,
    //                       items: [item])
    //    }
    
    func itemView(at index: Int) -> some View {
        Button(action: {
            //TODO: Change color of animation transition
            withAnimation { self.selectedIndex = index }
        }) {
            BottomBarItemView(selected: self.$selectedIndex, index: index, item: items[index])
        }
    }
    
    public var body: some View {
        HStack(alignment: .bottom) {
            ForEach(0..<items.count) { index in
                self.itemView(at: index)
                
                if index != self.items.count-1 {
                    Spacer()
                }
            }
        }
        .padding()
        .animation(.default)
        .background(
            Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)).edgesIgnoringSafeArea(.bottom)
        )
    }
    
    
}
