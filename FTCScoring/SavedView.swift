//
//  SavedView.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/2/20.
//

import SwiftUI
import CoreData

struct SavedView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Score.entity(), sortDescriptors: [])
    
    var scores: FetchedResults<Score>
    
    @State var showMatchInfo = false
    
    @State var sort: Int = 0
    
    var body: some View {
        if scores.isEmpty {
            NoScores()
        } else {
            Form {
                Section(header: Text("Scores")) {
                    switch sort {
                    case 1:
                        ForEach(scores.sorted{$0.date! < $1.date!}) { score in
                            ScoreItem(showMatchInfo: $showMatchInfo, score: score)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                viewContext.delete(scores[index])
                            }
                            do {
                                try viewContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    case 2:
                        ForEach(scores.sorted{$0.totalScore > $1.totalScore}) { score in
                            ScoreItem(showMatchInfo: $showMatchInfo, score: score)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                viewContext.delete(scores[index])
                            }
                            do {
                                try viewContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    case 3:
                        ForEach(scores.sorted{$0.totalScore < $1.totalScore}) { score in
                            ScoreItem(showMatchInfo: $showMatchInfo, score: score)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                viewContext.delete(scores[index])
                            }
                            do {
                                try viewContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    default:
                        ForEach(scores.sorted{$0.date! > $1.date!}) { score in
                            ScoreItem(showMatchInfo: $showMatchInfo, score: score)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                viewContext.delete(scores[index])
                            }
                            do {
                                try viewContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                }
                
            }
        }
        .listStyle(InsetListStyle())
            //        .navigationBarItems(trailing: EditButton())
            .navigationBarItems(leading: SortButton(sort: $sort), trailing: EditButton())
    }
    
}
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct SortButton: View {
    @Binding var sort: Int
    var body: some View {
        Menu {
            Button(action: {
                if sort == 0 {
                    sort = 1
                } else {
                    sort = 0
                }
            }, label: {
                Label("Sort by Date", systemImage: "calendar")
            })
            
            Button(action: {
                if sort == 2 {
                    sort = 3
                } else {
                    sort = 2
                }
            }, label: {
                Label("Sort by Score", systemImage: "list.number")
            })
            
        } label: {
            Image(systemName: "arrow.up.arrow.down").imageScale(.large)
        }
    }
}


struct SavedBreakdown: View {
    @Binding var showMatch: Bool
    @State private var shareSheet = false
    var score: Score
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Match Info")) {
                    SBTeamColor(color: Int(score.teamColor))
                    SBTeamNumber(number: score.teamNumber!)
                    SBMatchNumber(number: score.matchNumber!)
                    SBMatchDate(date: score.date!)
                }
                
                Section(header: Text("Autonomous")) {
                    SBAutonWobble(color: Int(score.teamColor), wobble: score.autonWobble)
                    SBAutonPark(launch: score.autonLaunch)
                    SBAutonRings(color: Int(score.teamColor), autonLow: Int(score.autonLow), autonMiddle: Int(score.autonMiddle), autonHigh: Int(score.autonHigh))
                    SBAutonPower(color: Int(score.teamColor), power: Int(score.autonPower))
                    TotalView(image: "Rings1", items: [
                        (Int(score.autonLow)*3),(Int(score.autonMiddle)*6),(Int(score.autonHigh)*12), (score.autonWobble ? 15 : 0), (score.autonLaunch ? 5 : 0)
                    ])
                }
                
                Section(header: Text("TeleOp")) {
                    SBTeleRings(color: Int(score.teamColor), teleLow: Int(score.teleLow), teleMiddle: Int(score.teleMiddle), teleHigh: Int(score.teleHigh))
                    TotalView(image: "Rings2", items: [
                        (Int(score.teleLow)*2),(Int(score.teleMiddle)*4),(Int(score.teleHigh)*6)
                    ])
                }
                
                Section(header: Text("Endgame")) {
                    SBEndWobble(color: Int(score.teamColor), wobble: Int(score.endWobble))
                    SBEndSupport(color: Int(score.teamColor), support: Int(score.endSupport))
                    SBEndPower(color: Int(score.teamColor), power: Int(score.endPower))
                    
                    TotalView(image: "Rings3", items: [
                        (score.endWobble == 0 ? 0 : score.endWobble == 1 ? 5 : 20), (Int(score.endSupport)*5), (Int(score.endPower)*15)
                    ])
                }
                VStack {
                    TotalView(text: "Autonomous",image: "Rings1", items: [
                        (Int(score.autonLow)*3),(Int(score.autonMiddle)*6),(Int(score.autonHigh)*12), (score.autonWobble ? 15 : 0), (score.autonLaunch ? 5 : 0)
                    ])
                    TotalView(text: "TeleOp",image: "Rings2", items: [
                        (Int(score.teleLow)*2),(Int(score.teleMiddle)*4),(Int(score.teleHigh)*6)
                    ])
                    TotalView(text: "Endgame",image: "Rings3", items: [
                        (score.endWobble == 0 ? 0 : score.endWobble == 1 ? 5 : 20), (Int(score.endSupport)*5), (Int(score.endPower)*15)
                    ])
                    TotalView(text: "Total Score",items: [Int(score.totalScore)])
                }
                
                Button(action: {
                    self.shareSheet = true
                }) {
                    HStack {
                        
                        
                        Text("Share Score")
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                .sheet(isPresented: $shareSheet, onDismiss: {
                    print("Dismiss")
                }, content: {
                    ActivityViewController(activityItems: ["My FTC team, \(score.teamNumber!), got \(score.totalScore) points using Skor! Check it out! https://ritesh.digital/skor"])
                })
                
            }
            .navigationTitle("Score Breakdown")
            .navigationBarItems(trailing:
                                    Button("Done") {
                                        showMatch.toggle()
                                    }
            )
        }
    }
}


struct TotalView: View {
    var text = "Total"
    var image = "Rings4"
    var items: Array<Int> = []
    var value: Int16 = 0
    var body: some View {
        HStack(alignment: .center) {
            ListImage(imageName: image)
            Text(text).fontWeight(.semibold)
            Spacer()
            if(items.isEmpty) {
                Text("\(value)")
                    .fontWeight(.medium)
            } else {
                Text("\(items.reduce(0, +))")
                    .fontWeight(.medium)
            }
            
        }
    }
}

struct SavedListItem: View {
    var score: Score
    static let shortDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(score.teamNumber!) | Match \(score.matchNumber!)")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("\(score.date!, formatter: Self.shortDateFormat)")
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            Spacer()
            Text("\(score.totalScore)")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(score.teamColor == 0 ? Color.blue : Color.red)
        }
        .padding(4)
    }
}

struct NoScores: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer()
            Image("noscores")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160)
                .padding()
                .offset(x: -10, y: 0)
                .padding(.top,-64)
            Text("No scores found!")
                .font(.system(size: 32, weight: .bold, design: .default))
                .fontWeight(.semibold)
                .foregroundColor(Color("AccentColor"))
            Text("Why don't you save some?")
                .fontWeight(.medium)
               
            Spacer()
        }
    }
}

struct ScoreItem: View {
    @Binding var showMatchInfo: Bool
    var score: Score
    var body: some View {
        Button(action: {
            self.showMatchInfo.toggle()
        }) {
            
            SavedListItem(score: score)
        }
        .sheet(isPresented: $showMatchInfo) {
            SavedBreakdown(showMatch: $showMatchInfo, score: score)
        }
    }
}
