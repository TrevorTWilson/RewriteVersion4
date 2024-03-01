//
//  test.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-29.
//

import SwiftUI

import SwiftUI

struct ContentView1: View {
    @State private var isSliderPresented = false
    @State private var selectedMinValue: Double = 0.0
    @State private var selectedMaxValue: Double = 0.0
    
    var body: some View {
        VStack {
            Button("Open Range Slider") {
                isSliderPresented.toggle()
            }
            
            if isSliderPresented {
                RangeSlider(
                    isPresented: $isSliderPresented,
                    attributeTitle: "Amps",
                    minValue: 90,
                    maxValue: 350,
                    onValueSelected: { minValue, maxValue in
                        selectedMinValue = minValue
                        selectedMaxValue = maxValue
                    }
                )
            }
            
            Text("Selected Min Value: \(selectedMinValue)")
            Text("Selected Max Value: \(selectedMaxValue)")
        }
        .padding()
    }
}

struct ContentView1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
    }
}
