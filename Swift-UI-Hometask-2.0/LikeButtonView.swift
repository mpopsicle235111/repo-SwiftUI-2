//
//  LikeButtonView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 02.06.2022.
//

import SwiftUI

struct LikeButtonView: View {
    
    @State private var isTapped = false
    //@State private var tapCounter = 0
    //Apply random number to counter to look nice
    @State private var tapCounter: Int = Int.random(in: 9...99)
    
    var body: some View {
        
        VStack(spacing: 10) {
            //This spacer pins view to the bottom of the PhotoCelView
            Spacer()
            HStack {
                //This spacer shifts the heart to the right
                Spacer()
                
                
            
                Text("\(tapCounter)").fontWeight(.bold)
                    .transition(.opacity.animation(.easeIn(duration: 1.9)))
                //ZStack - to show LikeButtonView on top of PhotoCellView
                ZStack {
                    
                    Image("GrayLayer-Small-Heart-img")
                        .scaleEffect(isTapped ? 1.0 : 0.1)
                        .scaledToFit()
                       
                    Image("GrayLayer-Small-GHeart-img")
                        .foregroundColor(.orange)
                        .scaledToFit()
                        .opacity(isTapped ? 0.0 : 1.0)
                        
                }
                //.foregroundColor(isTapped ? .red : .gray)
            }
            .font(.headline)
            //Shadow will make the text clear on white surfaces
            //.shadow(color: .black, radius: 10.0)
            .foregroundColor(.red)
            .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .bottomTrailing, endPoint: .bottomLeading))
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.7)) {
                    isTapped.toggle()
                    tapCounter += isTapped ? 1 : -1
                }
            }
        }
    }
}

struct LikeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LikeButtonView()
    }
}
