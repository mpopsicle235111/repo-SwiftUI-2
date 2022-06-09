//  MainTabBarController.swift
//
//  Created by Anton Lebedev on 04.06.2022.

// Here we have a NavigationBar at the bottom.
// Each element of this NavigationBar is a separate NavigationController.

import SwiftUI
import UIKit

let swiftUIView = UserView(groups: groupsData, friends: friendsData)
let viewCtrl = UIHostingController(rootView: swiftUIView)

final class UserCoordinator: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    var rootVC: UINavigationController
    
    
    init(vc: UIViewController) {
        rootVC = UINavigationController(rootViewController: vc)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return rootVC
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        //AppRouter.router.tabBarDidChangedTo(controller: uiViewController)
    }
    
}

final class FriendsCoordinator: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    var rootVC: UINavigationController
    
    init(vc: UIViewController) {
        rootVC = UINavigationController(rootViewController: vc)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return rootVC
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        //AppRouter.router.tabBarDidChangedTo(controller: uiViewController)
    }
}

final class GroupsCoordinator: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    var rootVC: UINavigationController
    
    init(vc: UIViewController) {
        rootVC = UINavigationController(rootViewController: vc)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return rootVC
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        //AppRouter.router.tabBarDidChangedTo(controller: uiViewController)
    }
}

final class NewsCoordinator: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    var rootVC: UINavigationController
    
    init(vc: UIViewController) {
        rootVC = UINavigationController(rootViewController: vc)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return rootVC
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        //AppRouter.router.tabBarDidChangedTo(controller: uiViewController)
    }
}


final class ExitCoordinator: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    var rootVC: UINavigationController
    
    init(vc: UIViewController) {
        rootVC = UINavigationController(rootViewController: vc)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return rootVC
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        //AppRouter.router.tabBarDidChangedTo(controller: uiViewController)
    }
}

//MARK: - Init

/// This basic view is used as State displayed to Window
struct BasicView: View {
    
    @Binding public var selectedIndex: Int
    
    let userCoordinator: UserCoordinator
    let friendsCoordinator: FriendsCoordinator
    let groupsCoordinator: GroupsCoordinator
    let newsCoordinator: NewsCoordinator
    let exitCoordinator: ExitCoordinator
    
    
    init(selectedIndex: Binding<Int>) {
        self._selectedIndex = selectedIndex
        //createCoordinator = CreateCoordinator(vc:
        // LaunchViewController(
        //             config:
        //                            .init(tags: tags,
        //                                  suggest: suggests)
        //                       )
        //        )
        userCoordinator = UserCoordinator(vc: UserViewController())
        
        //MARK: had to hardcode "id: 174145" here. Could not pass friend.id. User Jack uses Session.shared.userId fine...
        friendsCoordinator = FriendsCoordinator(vc: FriendsViewController(friend: FriendAPI.init(canAccessClosed: true, domain: String(), city: nil, id: 174145, photo100: String(), lastName: String(), photo50: String(), trackCode: String(), isClosed: Bool(), firstName: String())))
        groupsCoordinator = GroupsCoordinator(vc: GroupsViewController(group: GroupAPI.init(id: 0, name: String(), photo100: String(), screen_name: String())))
        newsCoordinator = NewsCoordinator(vc: NewsViewController())
        exitCoordinator = ExitCoordinator(vc: ExitViewController())
    }
    
    var body: some View {
        switch selectedIndex {
        case 0:
            userCoordinator
        case 1:
            friendsCoordinator
        case 2:
            groupsCoordinator
        case 3:
            newsCoordinator
        default:
            exitCoordinator
        }
    }
}

struct ContentView: View {
    
    let items: [BottomBarItem] = [
        .init(icon: .init(systemName: "house.fill")!,
              title: "Home",
              color: Color(.blue)),
        .init(icon: .init(systemName: "person.2.fill")!,
              title: "Friends",
              color: Color(.darkGray)),
        .init(icon: .init(systemName: "person.3")!,
              title: "Groups",
              color: Color(.green)),
        .init(icon: .init(systemName: "newspaper")!,
              title: "News",
              color: Color(.green)),
        .init(icon: .init(systemName: "eject.fill")!,
              title: "Exit",
              color: Color(.green))
    ]
    

    
    @State var currentIndex: Int = 0
    
    var body: some View {
        if #available(iOS 14.0, *) {
            ZStack(alignment: .bottom) {
                
                BasicView(selectedIndex: $currentIndex)
                
                BottomBar(selectedIndex: $currentIndex,
                          items: items)
                    //.padding(.vertical)
                
            }
            .ignoresSafeArea()
        } else {
            ZStack(alignment: .bottom) {
                
                BasicView(selectedIndex: $currentIndex)
                
                BottomBar(selectedIndex: $currentIndex,
                          items: items)
                    .padding(.vertical)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
