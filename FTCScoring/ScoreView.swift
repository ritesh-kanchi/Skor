//
//  ScoreView.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/2/20.
//

import SwiftUI
import CoreData

struct ScoreView: View {
    // Team Info
    @State private var teamColor = 0
    @State private var teamNumber = ""
    @State private var matchNumber = ""
    @State private var date = Date()
    @State private var notes: String = ""
    
    // Autonomous Scoring
    @State private var autonWobble = false
    @State private var autonWobble2 = false
    @State private var autonPark = false
    @State private var autonLow = 0
    @State private var autonMiddle = 0
    @State private var autonHigh = 0
    @State private var autonPower = 0
    
    // TeleOp Scoring
    @State private var teleLow = 0
    @State private var teleMiddle = 0
    @State private var teleHigh = 0
    
    // Endgame Scoring
    @State private var endWobble = 0
    @State private var endWobble2 = 0
    @State private var endSupport = 0
    @State private var endPower = 0
    
    
    @State private var totalScore = 0
    @State private var settingsSheet = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Form {
            Section(header: Text("Match Info")) {
                TeamColorPicker(color: $teamColor)
                TeamNumberInput(number: $teamNumber)
                MatchNumberInput(number: $matchNumber)
                MatchDateInput(date: $date)
                
            }
            Section(header: Text("Autonomous")) {
                AutonWobble(wobble: $autonWobble, wobble2: $autonWobble2, color: $teamColor)
                AutonPark(park: $autonPark)
                AutonRings(color: $teamColor, autonLow: $autonLow, autonMiddle: $autonMiddle, autonHigh: $autonHigh)
                AutonPowerBack(color: $teamColor, power: $autonPower)
                TotalView(image: "Rings1", value: calcAuton(wobble1: autonWobble, wobble2: autonWobble2, launchLine: autonPark, autonLow: autonLow, autonMid: autonMiddle, autonHigh: autonHigh, autonPower: autonPower))
            }
            Section(header: Text("Teleop")) {
                TeleRings(color: $teamColor, teleLow: $teleLow, teleMiddle: $teleMiddle, teleHigh: $teleHigh)
                TotalView(image: "Rings2", value:  calcTele(teleLow: teleLow, teleMid: teleMiddle, teleHigh: teleHigh))
            }
            Section(header: Text("Endgame")) {
                EndWobble(wobble: $endWobble, wobble2: $endWobble2)
                EndSupport(support: $endSupport, color: $teamColor)
                EndPower(color: $teamColor, power: $endPower)
                TotalView(image: "Rings3", value: calcEnd(endWobble1: endWobble, endWobble2: endWobble2, endSupport: endSupport, endPower: endPower))
            }
            Section(header: Text("Breakdown")) {
                // autonomous
                TotalView(text: "Autonomous", image: "Rings1", value: calcAuton(wobble1: autonWobble, wobble2: autonWobble2, launchLine: autonPark, autonLow: autonLow, autonMid: autonMiddle, autonHigh: autonHigh, autonPower: autonPower))
                
                
                // teleop
                TotalView(text: "TeleOp", image: "Rings2",value: calcTele(teleLow: teleLow, teleMid: teleMiddle, teleHigh: teleHigh))
                
                // end
                TotalView(text: "Endgame", image: "Rings3", value: calcEnd(endWobble1: endWobble, endWobble2: endWobble2, endSupport: endSupport, endPower: endPower))
                // all
                TotalView(text: "Total Score", value:
                            calcAuton(wobble1: autonWobble, wobble2: autonWobble2, launchLine: autonPark, autonLow: autonLow, autonMid: autonMiddle, autonHigh: autonHigh, autonPower: autonPower) +
                            calcTele(teleLow: teleLow, teleMid: teleMiddle, teleHigh: teleHigh) +
                            calcEnd(endWobble1: endWobble, endWobble2: endWobble2, endSupport: endSupport, endPower: endPower)
                )
            }
            Section(header: Text("Notes")) {
                TextEditor(text: $notes)
            }
            Button(action: {
                guard self.teamNumber != "" else {return}
                let newScore = Score(context: viewContext)
                
                // info
                newScore.id = UUID()
                newScore.teamColor = Int16(self.teamColor)
                newScore.teamNumber = self.teamNumber
                newScore.matchNumber = self.matchNumber
                newScore.date = self.date
                
                // auton
                newScore.autonWobble = self.autonWobble
                newScore.autonWobble2 = self.autonWobble2
                newScore.autonLaunch = self.autonPark
                newScore.autonLow = Int16(self.autonLow)
                newScore.autonMiddle = Int16(self.autonMiddle)
                newScore.autonHigh = Int16(self.autonHigh)
                newScore.autonPower = Int16(self.autonPower)
                
                //teleop
                newScore.teleLow = Int16(self.teleLow)
                newScore.teleMiddle = Int16(self.teleMiddle)
                newScore.teleHigh = Int16(self.teleHigh)
                
                // endgame
                newScore.endWobble = Int16(self.endWobble)
                newScore.endWobble2 = Int16(self.endWobble2)
                newScore.endSupport = Int16(self.endSupport)
                newScore.endPower = Int16(self.endPower)
                
                newScore.notes = self.notes
                
                // final
                let items = [(Int(self.autonLow)*3),(Int(self.autonMiddle)*6),(Int(self.autonHigh)*12), (self.autonWobble ? 15 : 0),(self.autonWobble2 ? 15 : 0),(Int(self.autonPower)*15), (self.autonPark ? 5 : 0), (Int(self.teleLow)*2),(Int(self.teleMiddle)*4),(Int(self.teleHigh)*6),
                             (self.endWobble == 0 ? 0 : self.endWobble == 1 ? 5 : 20), (self.endWobble2 == 0 ? 0 : self.endWobble2 == 1 ? 5 : 20), (Int(self.endSupport)*5), (Int(self.endPower)*15)]
                newScore.totalScore = Int64(items.reduce(0,+))
                
                do {
                    try viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
                
                
            }) {
                HStack {
                    Text("Save Score")
                    Spacer()
                    Image(systemName: "square.and.arrow.down")
                }
            }
        }
    }
    
    func calcAuton(wobble1: Bool, wobble2: Bool, launchLine: Bool, autonLow: Int, autonMid: Int, autonHigh: Int, autonPower: Int) -> Int16 {
        return Int16((Int(autonLow)*3)+(Int(autonMiddle)*6)+(Int(autonHigh)*12)+(autonWobble ? 15 : 0) + (autonWobble2 ? 15 : 0)+(autonPark ? 5 : 0) + (autonPower * 15))
    }
    
    func calcTele(teleLow: Int, teleMid: Int, teleHigh: Int) -> Int16 {
        return Int16((Int(teleLow)*2)+(Int(teleMid)*4)+(Int(teleHigh)*6))
    }
    
    func calcEnd(endWobble1: Int, endWobble2: Int, endSupport: Int, endPower: Int) -> Int16 {
        return Int16((endWobble == 0 ? 0 : endWobble == 1 ? 5 : 20) + (endWobble2 == 0 ? 0 : endWobble2 == 1 ? 5 : 20) + (Int(endSupport)*5)+(Int(endPower)*15))
    }
}


struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
