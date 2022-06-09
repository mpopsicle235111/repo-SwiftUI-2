//
//  PhotoCellView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 31.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotoCellView: View {
    
    var photoAPI: PhotoAPI
    @State private var photoPressed = false
    
    var body: some View {
       
        GeometryReader { proxy in
            WebImage(url: URL(string: photoAPI.sizes?.last?.url ?? "Beth-img"))
                .resizable() // Resizable like SwiftUI.Image
                // Supports ViewBuilder as well
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 90, alignment: .center)
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                //Photo's avatar animation:
                .scaleEffect(photoPressed ? 1.25 : 1.0)
                .onTapGesture {
                    withAnimation(.spring(response: 1.0,
                                          dampingFraction: 0.5,
                                          blendDuration: 0.2)) {
                        self.photoPressed.toggle()
                        }
                    self.photoPressed.toggle()
                }
                LikeButtonView()
            
        }
        
        
        
        /*HStack {
            WebImage(url: URL(string: photoAPI.sizes.last?.url ?? "Beth-img"))
                    .resizable() // Resizable like SwiftUI.Image
                    // Supports ViewBuilder as well
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
                    //User's avatar animation:
                    .scaleEffect(photoPressed ? 1.25 : 1.0)
                    .onTapGesture {
                        withAnimation(.spring(response: 1.0,
                                              dampingFraction: 0.5,
                                              blendDuration: 0.2)) {
                            self.photoPressed.toggle()
                            }
                        self.photoPressed.toggle()
                    }
            
        }*/
    }
}

struct PhotoCellView_Previews: PreviewProvider {
    var photosAPI: PhotosAPI
    static var previews: some View {
        PhotosView(viewModel: PhotosViewModel(friend: FriendAPI.init(canAccessClosed: true, domain: "", city: nil, id: 0, photo100: "", lastName: "", photo50: "", trackCode: "", isClosed: false, firstName: ""), api: PhotosAPI()))
    }
}


