//
//  ContentView.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/2/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @AppStorage("welcomeSheet") var welcomeSheet: Bool = true
    var body: some View {
        NavigationViews()
            .sheet(isPresented: $welcomeSheet, content: {
                WelcomeSheet(welcomeSheet: $welcomeSheet)
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        //        WelcomeSheet(welcomeSheet: .constant(true))
    }
}


struct WelcomeSheet: View {
    @Binding var welcomeSheet: Bool
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 16) {
                Image("SkorIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70, alignment: .center)
                Image("SkorLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50, alignment: .center)
                
                Text("The simple and intuitive FTC Scoring app.")
                    .foregroundColor(Color("AccentColor"))
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                
                Spacer()
                VStack(alignment: .leading) {
                    WelcomeListItem(icon: "sparkles", headline: "Score", text: "Score your matches, easier than ever.")
                    WelcomeListItem(icon: "bookmark.fill", headline: "Save", text: "Save your best scores and see score breakdowns.")
                    WelcomeListItem(icon: "square.and.arrow.up", headline: "Share", text: "Share your best scores with others with score breakdown.", divider: false)
                    
                }
                
                Spacer()
                Button(action: {
                    welcomeSheet = false
                }, label: {
                    Text("Continue")
                        .fontWeight(.medium)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(Color("AccentColor"))
                        .cornerRadius(12)
                })
            }
            .padding()
            .padding(.vertical,72)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("SkorBlack"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeListItem: View {
    var icon: String
    var headline: String
    var text: String
    var divider = true
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .frame(width: 40, height: 40)
                    
                    .foregroundColor(Color("AccentColor"))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(headline)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("AccentColor"))
                    Text(text)
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .fixedSize(horizontal: false, vertical: true)
                    
                }
                Spacer()
                
            }
            
            if divider {
                Divider()
                    .background(Color.white.opacity(0.15))
            }
        }
        .padding(.bottom, 8)
        .padding(.horizontal, 8)
    }
}
