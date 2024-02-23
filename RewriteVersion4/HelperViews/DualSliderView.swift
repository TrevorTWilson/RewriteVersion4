//
//  DualSliderView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-23.
//

import SwiftUI

struct DualSliderView: View {
    @State private var minRange: Double = 110
    @State private var maxRange: Double = 110
    var minRangeValue: Double
    var maxRangeValue: Double
    var step: Double
    var settingPassTitle: String
    var settingAttributeTitle: String
    @Binding var isPresented: Bool // Binding to toggle the view
    
    init(minRangeValue: Double, maxRangeValue: Double, step: Double, settingPassTitle: String, settingAttributeTitle: String, isPresented: Binding<Bool>) {
        self.minRangeValue = minRangeValue
        self.maxRangeValue = maxRangeValue
        self.step = step
        self.settingPassTitle = settingPassTitle
        self.settingAttributeTitle = settingAttributeTitle
        self._isPresented = isPresented
        
        self.minRange = minRangeValue
        self.maxRange = maxRangeValue
        _minRange = State(initialValue: minRangeValue)
        _maxRange = State(initialValue: maxRangeValue)
    }
    
    var body: some View {
        VStack {
            Text("Min/Max Range of \(settingAttributeTitle)")
                .font(.title)
                .padding()
            Text("For \(settingPassTitle)")
                .font(.title)
                .padding()
            Spacer()
            VStack {
                Text("Min Value: \(String(format: "%.2f", minRange))")
                Slider(value: $minRange, in: minRangeValue...(maxRangeValue - 1), step: step)
            }
            .padding(30)
            
            VStack {
                Text("Max Value: \(String(format: "%.2f", maxRange))")
                Slider(value: $maxRange, in: (minRangeValue + 1)...maxRangeValue, step: step)
            }
            .padding(30)
            
            



            
            HStack {
                Button("Cancel") {
                    isPresented = false // Dismiss the view without returning values
                }
                .padding()
                
                Button("Save") {
                    print(minRange)
                    print(maxRange)
                    isPresented = false // Dismiss the view
                    // Perform actions with minRange and maxRange values
                }
                .padding()
            }
            
            Spacer()
        }
    }
}


struct DualSliderView_Previews: PreviewProvider {
    @State static var isSliderViewPresented = false // Define the binding variable here
    
    static var previews: some View {
        DualSliderView(minRangeValue: 90, maxRangeValue: 320, step: 1, settingPassTitle: "Amps", settingAttributeTitle: "Amps", isPresented: $isSliderViewPresented)
    }
}

        //DualSliderView(minRangeValue: 8, maxRangeValue: 35, step: 0.1, settingPassTitle: "Volts", settingAttributeTitle: "Volts")
        //DualSliderView(minRangeValue: 50, maxRangeValue: 500, step: 1, settingPassTitle: "ArcSpeed", settingAttributeTitle: "ArcSpeed")
        //DualSliderView(minRangeValue: 0.50, maxRangeValue: 3.00, step: 0.01, settingPassTitle: "HeatInput", settingAttributeTitle: "HeatInput")
    



