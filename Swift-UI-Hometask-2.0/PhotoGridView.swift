//
//  PhotoGridView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 10.05.2022.
//  Photo grid array by Ameenah Burhan https://youtu.be/roIAA4dQsc8

import SwiftUI

struct PhotoGridView: View {
    
    let imageNames = ["house", "person.2.fill", "person.3", "newspaper", "eject.fill", "gear", "cloud.bolt", "star.fill", "heart.fill", "note", "doc.append", "calendar", "note.text", "person", "square.and.arrow.up", "folder", "bin.xmark", "tray", "pencil.circle", "tray.full", "sun.max", "cloud", "moon.zzz.fill" ]
   
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView {
                //An array of columns: we have 3 items in this array for our 3 columns
                LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                ], spacing: 3){
                    ForEach(imageNames, id: \.self){ imageName in
                        Image(systemName: imageName)
                            .frame(width: geo.size.width/3, height: geo.size.width/3)
                            .background(Color.gray)
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}

struct PhotoGridView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGridView()
    }
}
