//
//  FTCScoringApp.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/2/20.
//

import SwiftUI
import UIKit

@main
struct FTCScoringApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(IconNames())
        }
    }
}


class IconNames: ObservableObject {
    var iconNames : [String?] = [nil]
    @Published var currentIndex = 0
    init() {
        getAlternateIcons()
        
        if let currentIcon = UIApplication.shared.alternateIconName{
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    func getAlternateIcons() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String : Any] {
            
            for(_, value) in alternateIcons {
                guard let iconList = value as? Dictionary<String, Any> else {return}
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else {return}
                
                guard let icon = iconFiles.first else {return}
                
                iconNames.append(icon)
            }
        }
    }
}
