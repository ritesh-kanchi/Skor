//
//  NavigationViews.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/3/20.
//

import SwiftUI

enum NavigationItem {
    case score
    case save
    case timer
    case prefs
}

struct NavigationViews: View {
    @State var selection: Set<NavigationItem> = [.score]
    @State var timeRemaining = 10
    @State var timerActive = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        ZStack {
            if horizontalSizeClass == .compact {
                tabView
            } else {
                sidebar
            }
        }
    }
    
    var tabView: some View {
        TabView {
            NavigationView {
                content
                    .navigationTitle("Score")
            }
            .tabItem { Image(systemName: "tray.fill")
                Text("Score") }
            
            NavigationView {
                SavedView()
                    .navigationTitle("Saved")
            }
            .tabItem {
                Image(systemName: "bookmark.fill")
                Text("Saved")
            }
            
//            NavigationView {
//                TimerView(timeRemaining: $timeRemaining, timerActive: $timerActive)
//                    .navigationTitle("Timer")
//            }
//            .tabItem {
//                Image(systemName: "timer")
//                Text("Timer")
//            }
            NavigationView {
                SettingsView()
                    .navigationTitle("Preferences")
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Preferences")
            }
        }
    }
    
    var sidebar: some View {
        NavigationView {
            List(selection: $selection) {
                NavigationLink(destination: content
                                .navigationTitle("Score")) {
                    Label("Score", systemImage: "tray.fill")
                }
                .tag(NavigationItem.score)
                
                NavigationLink(destination: SavedView().navigationTitle("Saved")) {
                    Label("Saved", systemImage: "bookmark.fill")
                }
                .tag(NavigationItem.save)
                
//                NavigationLink(destination: TimerView(timeRemaining: $timeRemaining, timerActive: $timerActive).navigationTitle("Timer")) {
//                    Label("Timer", systemImage: "timer")
//                }
//                .tag(NavigationItem.timer)
                
                NavigationLink(destination: SettingsView()) {
                    Label("Preferences", systemImage: "gearshape.fill")
                }
                .tag(NavigationItem.prefs)
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Skor")
            content
                .navigationTitle("Score")
        }
    }
    
    var content: some View {
        ScoreView()
    }
}
