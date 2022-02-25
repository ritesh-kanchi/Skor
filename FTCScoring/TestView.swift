//
//  TestView.swift
//  FTCScoring
//
//  Created by Ritesh Kanchi on 10/2/20.
//

import SwiftUI

struct TestView: View {
    @State private var value = 0

      var body: some View {
//          Form {
            Section {
            StepperView(value: $value)
            }
//          }
//          .padding()
      }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct StepperView: View {
    @Binding var value: Int
    var body: some View {
        Stepper("\(value) Value\(value != 1 ? "s" : "")", value: $value, in: 0...3)
    }
}
