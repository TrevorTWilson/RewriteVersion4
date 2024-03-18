//
//  anotherSlider.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-23.
//


import SwiftUI

struct RangeSlider : View {
    @Environment(\.dismiss) private var dismiss
    @State var width: Double = 0
    @State var width1: Double = 15
    @State private var minRangeValue: Double = 0.0
    @State private var maxRangeValue: Double = 0.0
    @Binding var isRangeSliderSheetPresented: Bool
    var onValueSelected: ((Double, Double) -> Void)?
    
    var attributeTitle: String
    var descriptor: String
    var minValue: Double
    var maxValue: Double
    var initialMinValue: Double
    var initialMaxValue: Double
    var mappingValue: Double
    var resolution: Double
    
    let totalWidth = UIScreen.main.bounds.width - 100
    
    init(isRangeSliderSheetPresented: Binding<Bool>, attributeTitle: String, descriptor: String, minValue: Double, maxValue: Double, initialMinValue: Double, initialMaxValue: Double, resolution: Double, onValueSelected: ((Double, Double) -> Void)? = nil) {
        _isRangeSliderSheetPresented = isRangeSliderSheetPresented
        self.attributeTitle = attributeTitle
        self.descriptor = descriptor
        self.minValue = minValue
        self.maxValue = maxValue
        self.initialMinValue = initialMinValue
        self.initialMaxValue = initialMaxValue
        self.mappingValue = maxValue - minValue
        self.resolution = resolution
        
        let initialWidth = Double(((self.initialMinValue - self.minValue) / (self.maxValue - self.minValue) * totalWidth))
        let initialWidth1 = Double(((self.initialMaxValue - self.minValue) / (self.maxValue - self.minValue) * totalWidth))
        
        _width = State(initialValue: initialWidth)
        _width1 = State(initialValue: initialWidth1)
        
        self.onValueSelected = onValueSelected
    }
    
    
    var body: some View {
        VStack {
            Text(attributeTitle)
                .font(.title)
                .fontWeight(.bold)
            Text(descriptor)
                .font(.title2)
            
            
            Text("\(self.getValue(value: ((self.width / self.totalWidth)*mappingValue)+minValue, resolution: self.resolution)) - \(self.getValue(value: ((self.width1 / self.totalWidth)*mappingValue)+minValue, resolution: self.resolution))")
                .fontWeight(.bold)
                .padding(.top)
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.black.opacity(0.20))
                    .frame(width: self.totalWidth,height: 6)
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: self.width1 - self.width, height: 14)
                    .offset(x: self.width) //+ 18
                
                HStack(spacing: 0) {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 18, height: 18)
                        .offset(x: self.width)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    if value.location.x >= 0 && value.location.x <= self.width1 {
                                        self.width = value.location.x
                                        self.minRangeValue = Double(getValue(value: ((self.width / self.totalWidth)*mappingValue)+minValue, resolution: self.resolution))!
                                    }
                                })
                        )
                    
                    Circle()
                        .fill(Color.black)
                        .frame(width: 18, height: 18)
                        .offset(x: self.width1 - 18)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    if value.location.x <= self.totalWidth && value.location.x >= self.width {
                                        self.width1 = value.location.x
                                        self.maxRangeValue = Double(getValue(value: ((self.width1 / self.totalWidth)*mappingValue)+minValue, resolution: self.resolution))!
                                    }
                                })
                        )
                }
            }
            HStack{
                Spacer()
                Button("Save") {
                    // Update the minRangeValue and maxRangeValue
                    let newMinRangeValue = Double(self.getValue(value: ((self.width / self.totalWidth) * self.mappingValue) + self.minValue, resolution: self.resolution))
                    let newMaxRangeValue = Double(self.getValue(value: ((self.width1 / self.totalWidth) * self.mappingValue) + self.minValue, resolution: self.resolution))
                    
                    if let minRangeValue = newMinRangeValue, let maxRangeValue = newMaxRangeValue {
                        self.minRangeValue = minRangeValue
                        self.maxRangeValue = maxRangeValue
                    } else {
                        print("Error converting values.")
                    }
                    
                    // Return the updated minRangeValue and maxRangeValue values to the caller
                    guard let onValueSelected = onValueSelected else { return }
                    onValueSelected(self.minRangeValue, self.maxRangeValue)
                    
                    // Dismiss the view
                    isRangeSliderSheetPresented = false
                }
                Spacer()
                Button("Cancel") {
                    // Dismiss the view
                    isRangeSliderSheetPresented = false
                }
                Spacer()
            }
            .padding(.top, 25)
        }
        .padding()
    }
    
    private func getValue(value: Double, resolution: Double) -> String {
        var newValue = value
        if newValue < self.minValue {
            newValue = self.minValue
        } else {
            newValue = (value / resolution).rounded() * resolution // Round the value 
        }
        let decimalPlaces = Int(-log10(resolution))
        let formatString = String(format: "%%.%df", decimalPlaces)
        let formattedString = String(format: formatString, newValue)
        
        return formattedString
    }
    
    
}

struct RangeSlider_Previews: PreviewProvider {
    @State static var isRangeSliderSheetPresented: Bool = false
    @State static var selectedMinValue: Double = 0.0
    @State static var selectedMaxValue: Double = 0.0
    
    static var previews: some View {
        var rangeSlider = RangeSlider(
            isRangeSliderSheetPresented: $isRangeSliderSheetPresented,
            attributeTitle: "Amps",
            descriptor: "Add New Range",
            minValue: 0,
            maxValue: 300,
            initialMinValue: 50,
            initialMaxValue: 250,
            resolution: 1
        )
        rangeSlider.onValueSelected = { minValue, maxValue in
            selectedMinValue = minValue
            selectedMaxValue = maxValue
            print("Min Value: \(selectedMinValue), Max Value: \(selectedMaxValue)")
        }
        
        return rangeSlider
    }
}







