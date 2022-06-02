//
//  PhotosView.swift
//  Swift-UI-Hometask-2.0
//
//  Created by Anton Lebedev on 31.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotosView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var showPhotosState: ShowPhotosState
    @ObservedObject var viewModel: PhotosViewModel
    
    init(viewModel: PhotosViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Spacer()
        VStack {
            VStack {
                WebImage(url: URL(string: viewModel.friend.photo100 ?? ""))
                        .resizable() // Resizable like SwiftUI.Image
                        // Supports ViewBuilder as well
                        
                        //This is good code:
                        //.placeholder {
                            //Rectangle().foregroundColor(.gray)
                        //}
                        //The below placeholder is just a stub to
                        //see iser's hardcoded image in a tab with user's own pictures
                        .placeholder(Image("Jack-img"))
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)

                Text("Photos:")
                Text("\((viewModel.friend.lastName )) \(viewModel.friend.firstName )")
                
                        
            }
                
                
        }
        
        GeometryReader{ geo in
                ScrollView {
                    //An array of columns: we have 3 items in this array for our 3 columns
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 3){
                        ForEach(viewModel.photosAPI.sorted(by: { $0.date < $1.date})){ photoAPI in
                            NavigationLink(destination: PhotoGridView()) {

                                PhotoCellView(photoAPI: photoAPI)
                                }
                                .frame(width: geo.size.width/3, height: geo.size.width/3)
                                .background(Color.gray)
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
            
        
        
            /*List(viewModel.photosAPI.sorted(by: { $0.date < $1.date})) { photoAPI in
                NavigationLink(destination: PhotoGridView()) {

                    PhotoCellView(photoAPI: photoAPI)
                    }
            
                }*/
            .onAppear { viewModel.fetch() }
         }
         
    }
    
    




struct PhotosPView_Previews: PreviewProvider {
    var photosAPI: PhotosAPI
    static var previews: some View {
        PhotosView(viewModel: PhotosViewModel(friend: FriendAPI.init(canAccessClosed: true, domain: "", city: nil, id: 7822904, photo100: "", lastName: "", photo50: "", trackCode: "", isClosed: false, firstName: ""), api: PhotosAPI()))
    }
}

