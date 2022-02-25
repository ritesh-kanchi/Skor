//
//  SettingsView.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/2/20.
//

import SwiftUI

struct SettingsView: View {
    
    @State var currentIcon = UIApplication.shared.alternateIconName
    
    
    var body: some View {
                Form {
                    Section(header: Text("About Skor")) {
                        HStack(alignment: .center, spacing: 12) {
                            Image(currentIcon ?? "Original")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 48, height: 48)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                                    )
                            VStack(alignment: .leading, spacing: 4) {
                                HStack(spacing: 4) {
                                    Text("Skor")
                                        .font(.headline)
                                        .fontWeight(.semibold)
//                                            CourseGroup(text: "Beta", color: Color("white"), bg: .accentColor)
                                    Spacer()
                                }
                                Text("Version \((Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String)!)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        
                        NavigationLink(destination: ChangeIconView(currentIcon: $currentIcon).navigationTitle("Change Icon")) {
                            Text("Change Icon")
                        }
                      
                    }
                    Section(header: Text("About FIRST")) {
                        NavigationLink(destination: AboutFTC()) {
                            Text("About FTC")
                        }
                        NavigationLink(destination: GeneralScoring()) {
                            Text("Scoring")
                        }
                      
                    }
                    Section(header: Text("More Info")) {
                        Button("Reset Welcome") {
                            UserDefaults.standard.set(true, forKey: "welcomeSheet")
                        }
                        Link(destination: URL(string: "https://twitter.com/ritesh_kanchi")!) {
                            Text("Twitter")
                        }
                    }
                }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct BasicListItem: View {
    var text: String
    var showDivider = true
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(text)
                    .foregroundColor(Color.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .medium, design: .default))
            }
            if showDivider {
                Divider()
            }
        }
    }
}

let iconNames =  ["Default", "Invert", "Blue","Orange","Black"]
let iconImages = ["Original", "Invert", "Blue","Orange","Black"]
let iconIcons = ["Original", "Invert", "Blue","Orange","Black"]

struct ChangeIconView: View {
    @Binding var currentIcon: String?
    var body: some View {
        Form {
            Section(header: Text("Icon Options")) {
            ForEach(0..<iconNames.count, id: \.self) { index in
                AltIconView(currentIcon: $currentIcon, index: index)
            }}
        }
        .listStyle(InsetListStyle())
    }
}

struct AltIconView: View {
    @Binding var currentIcon: String?
    var index: Int
    var body: some View {
        Button(action: {
            
            if UIApplication.shared.supportsAlternateIcons {
                
                
                let altIconName = iconIcons[index] == "Original" ? nil : iconIcons[index]
                
                
                UIApplication.shared.setAlternateIconName(altIconName) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Success!")
                    }
                }
            } else {
                print("Cannot Change Icon")
            }
            
            currentIcon = UIApplication.shared.alternateIconName ?? "Original"
        }) {
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                        Image(iconImages[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    Text(iconNames[index])
                        .foregroundColor(.primary)
                        .fontWeight(.medium)
                    Spacer()
                    if iconIcons[index] == currentIcon {
                        VStack {
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(Color("AccentColor"))
                                .font(.system(size: 16, weight: .medium, design: .default))
                            Spacer()
                        }
                    }
            }
            .padding(.vertical, 8)
        }
    }
}
}


struct AboutFTC: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
              Text("Code, Design, and Compete with Robots!")
                .font(.title3)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.bottom,4)
                Text("FIRST Tech Challenge students learn to think like engineers. Teams design, build, and code robots to compete in an alliance format against other teams. Robots are built from a reusable platform, powered by Android technology, and can be coded using a variety of levels of Java-based programming.").padding(.bottom,8)
                
                Text("Start a Team")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.bottom,4)
                  Text("The really cool thing about FIRST Tech Challenge is...all skill levels are welcomed and needed, technical or non-technical. Student and adult team members are encouraged to bring any skills they already have, like coding, electronics, metalworking, graphic design, web creation, public speaking, videography, and more.")
                    .padding(.bottom,8)
                Link(destination: URL(string: "https://www.firstinspires.org/robotics/ftc")!) {
                    
                    Text("Learn More")
                        .fontWeight(.medium)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(Color("AccentColor"))
                        .cornerRadius(12)
                      
                }
                
//                Form {
//                    Link(destination: URL(string: "https://www.firstinspires.org/resource-library/ftc/game-and-season-info")!) {
//
//                        Text("Learn More")
//    //                            .fontWeight(.medium)
//    //                            .padding(12)
//    //                            .frame(maxWidth: .infinity)
//    //                            .foregroundColor(Color.white)
//    //                            .background(Color("AccentColor"))
//    //                            .cornerRadius(12)
//    //
//                    }
//                }
                
                
            }.padding().navigationBarTitle("About FTC")
        }
    }
}

struct GeneralScoring: View {
    var body: some View {

                Form {
                    Section(header: Text("Autonomous")) {
                        GenScoreItem(image: "BlueWobble", text: "Wobble Goal Delievery", point: "15")
                        GenScoreItem(image: "LaunchLine", text: "Parked on Launch Line", point: "5")
                        GenScoreItem(image: "BlueLow", text: "Low Rings", point: "3")
                        GenScoreItem(image: "BlueMiddle", text: "Middle Rings", point: "6")
                        GenScoreItem(image: "BlueHigh", text: "High Rings", point: "12")
                        GenScoreItem(image: "BluePower", text: "Power Shot Targets", point: "15/Target")
                    }
                    
                        Section(header: Text("TeleOp")) {
                            GenScoreItem(image: "BlueLow", text: "Low Rings", point: "2")
                            GenScoreItem(image: "BlueMiddle", text: "Middle Rings", point: "4")
                            GenScoreItem(image: "BlueHigh", text: "High Rings", point: "6")
                        }
                    
                        Section(header: Text("Endgame")) {
                            GenScoreItem(image: "BlueWobble", text: "Wobble Goal Start Line", point: "15")
                            GenScoreItem(image: "RedWobble", text: "Wobble Goal Drop Zone", point: "20")
                            GenScoreItem(image: "BlueWobbleSupported", text: "Rings Supported", point: "5 each")
                            GenScoreItem(image: "BluePower", text: "Power Shot Targets", point: "15/Target")
                        }
                    Link(destination: URL(string: "https://www.firstinspires.org/resource-library/ftc/game-and-season-info")!) {
                        
                        Text("Learn More")
//                            .fontWeight(.medium)
//                            .padding(12)
//                            .frame(maxWidth: .infinity)
//                            .foregroundColor(Color.white)
//                            .background(Color("AccentColor"))
//                            .cornerRadius(12)
//
                    }
                } .navigationBarTitle("Scoring")
            
    }
}


struct GenScoreItem: View {
    var image: String
    var text: String
    var point: String
    var body: some View {
        HStack {
            ListImage(imageName: image)
            Text(text)
            Spacer()
            Text(point)
        }
    }
}
