//
//  ScoreTele.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/2/20.
//

import SwiftUI

struct TeleRings: View {
    @Binding var color: Int
    @Binding var teleLow: Int
    @Binding var teleMiddle: Int
    @Binding var teleHigh: Int
    var body: some View {
        VStack {
        HStack {
            ListImage(imageName: self.color == 0 ? "BlueLow" : "RedLow")
            Stepper("\(teleLow) Low Ring\(teleLow != 1 ? "s" : "")", value: $teleLow, in: 0...ringCap)
        }
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueMiddle" : "RedMiddle")
                Stepper("\(teleMiddle) Middle Ring\(teleMiddle != 1 ? "s" : "")", value: $teleMiddle, in: 0...ringCap)
            }
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueHigh" : "RedHigh")
                Stepper("\(teleHigh) High Ring\(teleHigh != 1 ? "s" : "")", value: $teleHigh, in: 0...ringCap)
            }
        }
    }
}


struct SBTeleRings: View {
     var color: Int
     var teleLow: Int
     var teleMiddle: Int
     var teleHigh: Int
    var body: some View {
        VStack {
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueLow" : "RedLow")
                Text("Low Ring\(teleLow != 1 ? "s" : "")")
                Spacer()
                Text("\(teleLow)")
            }
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueMiddle" : "RedMiddle")
                Text("Middle Ring\(teleMiddle != 1 ? "s" : "")")
                Spacer()
                Text("\(teleMiddle)")
            }
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueHigh" : "RedHigh")
                Text("High Ring\(teleHigh != 1 ? "s" : "")")
                Spacer()
                Text("\(teleHigh)")
            }
        }
        }
}
