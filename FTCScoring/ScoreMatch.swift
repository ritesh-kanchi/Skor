//
//  ScoreMatch.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/2/20.
//

import SwiftUI
import Combine

struct TeamColorPicker: View {
    var teamColors = ["Blue","Red"]
    @Binding var color: Int
    var body: some View {
        HStack(alignment: .center) {
            TeamColorIcon(color: color)
            Text("Team Color")
            Spacer()
            Picker(selection: $color, label: Text("Picker")) {
                ForEach(0..<teamColors.count) { index in
                    Text(self.teamColors[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 100)
        }
    }
}

struct SBTeamColor: View {
    var teamColors = ["Blue","Red"]
    var color: Int
    var body: some View {
        HStack(alignment: .center) {
            TeamColorIcon(color: color)
            Text("Team Color")
            Spacer()
            Text(teamColors[color])
        }
    }
}


struct TeamNumberInput: View {
    @Binding var number: String
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "number.circle.fill")
                .font(.system(size: 18))
                .frame(width: 24, height: 24)
                .foregroundColor(Color("AccentColor"))
            Text("Team #")
            
            TextField("14786", text: $number)
//                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .onReceive(Just(number)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.number = filtered
                                }
                    
                    if newValue.count > 6 {
                                   self.number.removeLast()
                               }
                }
        }
    }
    
}

struct SBTeamNumber: View {
    var number: String
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "number.circle.fill")
                .font(.system(size: 18))
                .frame(width: 24, height: 24)
                .foregroundColor(Color("AccentColor"))
            Text("Team #")
            Spacer()
            Text(number)
        }
    }
}



struct MatchNumberInput: View {
    @Binding var number: String
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "number.square.fill")
                .font(.system(size: 18))
                .frame(width: 24, height: 24)
                .foregroundColor(Color("AccentColor"))
            Text("Match #")
            TextField("25", text: $number)
//                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .onReceive(Just(number)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.number = filtered
                                }
                    
                    if newValue.count > 3 {
                                   self.number.removeLast()
                               }
                }

            
        }
    }
    
}

struct SBMatchNumber: View {
    var number: String
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "number.square.fill")
                .font(.system(size: 18))
                .frame(width: 24, height: 24)
                .foregroundColor(Color("AccentColor"))
            Text("Match #")
            Spacer()
            Text(number)
        }
    }
}

struct MatchDateInput: View {
    @Binding var date: Date
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "calendar")
                .font(.system(size: 18))
                .frame(width: 24, height: 24)
                .foregroundColor(Color("AccentColor"))
            Text("Date")
            Spacer()
            DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                Text("Select a date")
            }
            .datePickerStyle(CompactDatePickerStyle())
            .labelsHidden()
        }
    }
}

struct SBMatchDate: View {
    var date: Date
    static let shortDateFormat: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateStyle = .short
           return formatter
       }()
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "calendar")
                .font(.system(size: 18))
                .frame(width: 24, height: 24)
                .foregroundColor(Color("AccentColor"))
            Text("Date")
            Spacer()
            Text("\(date, formatter: Self.shortDateFormat)")
        }
    }
}

struct TeamColorIcon: View {
    var animate = true
    var color: Int
    var body: some View {
        RoundedRectangle(cornerRadius: color == 0 ? 6 : 100)
            .fill(color == 0 ? Color.blue : Color.red)
            .frame(width: 24, height: 24)
            .animation(animate ? .linear : nil)
    }
}
