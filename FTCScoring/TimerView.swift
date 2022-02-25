//
//  TimerView.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/2/20.
//

import SwiftUI

struct TimerView: View {
    @Binding var timeRemaining: Int
    @Binding var timerActive: Bool
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        var equating = true
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            TimerCard()
            TimerCard()
              Spacer()
//            Text("\(timeRemaining)")
//                .onReceive(timer) { _ in
//                    if self.timerActive {
//                    if self.timeRemaining > 0 {
//                        self.timeRemaining -= 1
//                    }
//                        if self.timeRemaining == 0 {
//                            self.timerActive = false
//                        }
//                    }
//                }
//            if(timeRemaining > 0) {
//            Button(timerActive ? "Pause" : "Start") {
//                self.timerActive.toggle()
//            }
//            } else {
//                Button("Reset") {
//                    self.timeRemaining = 10
//                }
//            }

        }
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timeRemaining: .constant(10), timerActive: .constant(false))
    }
}

struct TimerCard: View {
    var body: some View {
        VStack {
            Text("30")
                .font(.system(size: 120, weight: .bold, design: .rounded))
            Text("Seconds".uppercased())
                .font(.body)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(Color.white)
        .background(Color("AccentColor"))
        .cornerRadius(16)
        .padding()
    }
}
