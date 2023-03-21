//
//  ContentView.swift
//  Interpolation
//
//  Created by Alex Agapov on 20.03.2023.
//

import SwiftUI
import LerpRemap

struct ContentView: View {

    @State var t0: CGFloat = 0
    @State var t: CGFloat = 0

    var body: some View {
        VStack {
            Text("Lerp example")
                .font(.title)
            Spacer()
            Text("0 to 1 (clamped). Current: \(t0)")
            slider($t0, in: 0...1, value: t0.lerp(min: 0, max: 100))
            Spacer()
            Text("-1 to 2 (clamped). Current: \(t)")
            slider($t, in: -1...2, value: t.lerp(min: 0, max: 100).clamped(min: 0, max: 100))
            Spacer()
            Text("-1 to 2 (unclamped). Current: \(t)")
            slider($t, in: -1...2, value: t.lerp(min: 0, max: 100))
        }
        .padding(.all)
        .monospacedDigit()
    }

    private func slider(
        _ binding: Binding<CGFloat>,
        in inputRange: ClosedRange<CGFloat>,
        value: CGFloat
    ) -> some View {
        VStack {
            Slider(value: binding, in: inputRange)
            Text("\(value)")
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
