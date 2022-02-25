//
//  ScoreEnd.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/2/20.
//

import SwiftUI

struct EndWobble: View {
    @Binding var wobble: Int
    @Binding var wobble2: Int
    var wobbleAreas = ["None","Start Line", "Drop Zone"]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Wobble Goal #1 Delivery")
                Picker(selection: $wobble, label: Text("Picker")) {
                    ForEach(0..<wobbleAreas.count) { index in
                        Text(self.wobbleAreas[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            VStack(alignment: .leading) {
                Text("Wobble Goal #2 Delivery")
                Picker(selection: $wobble2, label: Text("Picker")) {
                    ForEach(0..<wobbleAreas.count) { index in
                        Text(self.wobbleAreas[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}


struct SBEndWobble: View {
    var color: Int
    var wobble: Int
    var wobbleAreas = ["None","Start Line", "Drop Zone"]
    var body: some View {
        HStack(alignment: .center) {
            ListImage(imageName: self.color == 0 ? "BlueWobble" : "RedWobble")
            Text("Wobble Goal Delivery")
            Spacer()
            Text(wobbleAreas[wobble])
        }
    }
}

struct EndSupport: View {
    @Binding var support: Int
    @Binding var color: Int
    var body: some View {
        HStack {
            ListImage(imageName: self.color == 0 ? "BlueWobbleSupported" : "RedWobbleSupported")
            Stepper("\(support) Supported Ring\(support != 1 ? "s" : "")", value: $support, in: 0...ringCap)
        }
    }
}

struct SBEndSupport: View {
    var color: Int
    var support: Int
    var body: some View {
        HStack(alignment: .center) {
            ListImage(imageName: self.color == 0 ? "BlueWobbleSupported" : "RedWobbleSupported")
            Text("Supported Ring\(support != 1 ? "s" : "")")
            Spacer()
            Text("\(support)")
        }
    }
}


struct EndPower: View {
    @Binding var color: Int
    @Binding var power: Int
    var body: some View {
        HStack {
            ListImage(imageName: self.color == 0 ? "BluePower" : "RedPower")
            Stepper("\(power) Power Shot\(power != 1 ? "s" : "")", value: $power, in: 0...3)
        }
    }
}

struct SBEndPower: View {
    var color: Int
    var power: Int
    var body: some View {
        HStack(alignment: .center) {
            ListImage(imageName: self.color == 0 ? "BluePower" : "RedPower")
            Text("Power Shot\(power != 1 ? "s" : "")")
            Spacer()
            Text("\(power)")
        }
    }
}


