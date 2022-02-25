//
//  ScoreAuton.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/2/20.
//

import SwiftUI

let ringCap = 100

struct AutonWobble: View {
    @Binding var wobble: Bool
    @Binding var wobble2: Bool
    @Binding var color: Int
    var body: some View {
        VStack {
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueWobble" : "RedWobble")
                Toggle(isOn: $wobble) {
                    Text("Wobble Goal #1 Delivery")
                }
            }
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueWobble" : "RedWobble")
                Toggle(isOn: $wobble2) {
                    Text("Wobble Goal #2 Delivery")
                }
            }
        }
    }
}

struct SBAutonWobble: View {
    var color: Int
    var wobble: Bool
    var body: some View {
        HStack(alignment: .center) {
            ListImage(imageName: self.color == 0 ? "BlueWobble" : "RedWobble")
            Text("Wobble Goal Delivery")
            Spacer()
            Image(systemName: wobble ? "checkmark.square.fill" : "xmark.square.fill")
                .foregroundColor(wobble ? Color.green : Color.red)
        }
    }
}


struct AutonPark: View {
    @Binding var park: Bool
    var body: some View {
        HStack {
            ListImage(imageName: "LaunchLine")
            Toggle(isOn: $park) {
                Text("Launch Line Park")
            }
        }
    }
}

struct SBAutonPark: View {
    var launch: Bool
    var body: some View {
        HStack(alignment: .center) {
            ListImage(imageName: "LaunchLine")
            Text("Launch Line Park")
            Spacer()
            Image(systemName: launch ? "checkmark.square.fill" : "xmark.square.fill")
                .foregroundColor(launch ? Color.green : Color.red)
        }
    }
}


struct AutonRings: View {
    @Binding var color: Int
    @Binding var autonLow: Int
    @Binding var autonMiddle: Int
    @Binding var autonHigh: Int
    var body: some View {
        VStack {
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueLow" : "RedLow")
                Stepper("\(autonLow) Low Ring\(autonLow != 1 ? "s" : "")", value: $autonLow, in: 0...ringCap)
            }
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueMiddle" : "RedMiddle")
                Stepper("\(autonMiddle) Middle Ring\(autonMiddle != 1 ? "s" : "")", value: $autonMiddle, in: 0...ringCap)
            }
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueHigh" : "RedHigh")
                Stepper("\(autonHigh) High Ring\(autonHigh != 1 ? "s" : "")", value: $autonHigh, in: 0...ringCap)
            }
        }
    }
}

struct SBAutonRings: View {
     var color: Int
     var autonLow: Int
     var autonMiddle: Int
     var autonHigh: Int
    var body: some View {
        VStack {
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueLow" : "RedLow")
                Text("Low Ring\(autonLow != 1 ? "s" : "")")
                Spacer()
                Text("\(autonLow)")
            }
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueMiddle" : "RedMiddle")
                Text("Middle Ring\(autonLow != 1 ? "s" : "")")
                Spacer()
                Text("\(autonMiddle)")
            }
            HStack {
                ListImage(imageName: self.color == 0 ? "BlueHigh" : "RedHigh")
                Text("High Ring\(autonLow != 1 ? "s" : "")")
                Spacer()
                Text("\(autonHigh)")
            }
        }
        }
}


struct AutonPowerBack: View {
    @Binding var color: Int
    @Binding var power: Int
    var body: some View {
        HStack {
            ListImage(imageName: self.color == 0 ? "BluePower" : "RedPower")
            Stepper("\(power) Power Shot\(power != 1 ? "s" : "")", value: $power, in: 0...3)
        }
    }
}

struct SBAutonPower: View {
    var color: Int
    var power: Int
    var body: some View {
        HStack {
            ListImage(imageName: self.color == 0 ? "BluePower" : "RedPower")
            Text("Power Shot\(power != 1 ? "s" : "")")
            Spacer()
            Text("\(power)")
        }
    }
}

