//
//  anotherSlider.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-23.
//


import SwiftUI

struct RangeSlider : View {
    @State var width: CGFloat = 0
    @State var width1: CGFloat = 15
    @State private var minRangeValue: Double = 0.0
    @State private var maxRangeValue: Double = 0.0
    @Binding var isPresented: Bool


    var onValueSelected: ((Double, Double) -> Void)? = nil


    var totalWidth = 320.0
    var attributeTitle: String
    var minValue: Double
    var maxValue: Double
    var mappingValue: Double
    
    init(isPresented: Binding<Bool>,width: CGFloat = 0, width1: CGFloat = 15, totalWidth: Double = 320.0, attributeTitle: String, minValue: Double, maxValue: Double, minRangeValue: Double = 0.0, maxRangeValue: Double = 0.0, mappingValue:Double = 0.0) {
        _isPresented = isPresented
        self.width = width
        self.width1 = width1
        self.totalWidth = totalWidth
        self.attributeTitle = attributeTitle
        self.minValue = minValue
        self.maxValue = maxValue
        self.minRangeValue = minValue
        self.maxRangeValue = maxValue
        self.mappingValue = maxValue-minValue
    }
    
    var body: some View {
        
            VStack {
                Text(attributeTitle)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("\(self.getValue(value: ((self.width / self.totalWidth)*mappingValue)+minValue)) - \(self.getValue(value: ((self.width1 / self.totalWidth)*mappingValue)+minValue))")
                    .fontWeight(.bold)
                    .padding(.top)
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.black.opacity(0.20))
                        .frame(width: self.totalWidth,height: 6)
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: self.width1 - self.width, height: 6)
                        .offset(x: self.width + 18)
                    
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
                                            self.minRangeValue = Double(getValue(value: ((self.width / self.totalWidth)*mappingValue)+minValue))!
                                            print(minRangeValue, maxRangeValue)
                                        }
                                        
                                    })
                            )
                        
                        Circle()
                            .fill(Color.black)
                            .frame(width: 18, height: 18)
                            .offset(x: self.width1)
                            .gesture(
                                DragGesture()
                                    .onChanged({ value in
                                        if value.location.x <= self.totalWidth && value.location.x >= self.width {
                                            self.width1 = value.location.x
                                            self.maxRangeValue = Double(getValue(value: ((self.width1 / self.totalWidth)*mappingValue)+minValue))!
                                            print(minRangeValue, maxRangeValue)
                                        }
                                        
                                    })
                            )
                    }
                }
                HStack{
                    Spacer()
                    Button("Save") {
                        // Return collected values minRangeValue and maxRangeValues to the caller
                        guard let onValueSelected = onValueSelected else { return }
                        onValueSelected(minRangeValue, maxRangeValue)
                        // Dismiss the view
                        isPresented.toggle()
                    }






                    Spacer()
                    Button("Cancel") {
                         // Dismiss the view
                        isPresented.toggle()
                    }
                    Spacer()
                }
                
                .padding(.top, 25)
            }
            .padding()
        
        }
       
    private func getValue(value: CGFloat) -> String {
        var newValue = value
        if newValue < 90 {
            newValue = value + minValue
        } else {
            newValue = value
        }
        return String(format: "%.0f", newValue)
    }
}



struct RangeSlider_Previews: PreviewProvider {
    @State static var isPresented: Bool = false
    @State static var selectedMinValue: Double = 0.0
    @State static var selectedMaxValue: Double = 0.0
    
    static var previews: some View {
        var rangeSlider = RangeSlider(
            isPresented: $isPresented,
            attributeTitle: "Amps",
            minValue: 90,
            maxValue: 350
        )
        rangeSlider.onValueSelected = { minValue, maxValue in
            selectedMinValue = minValue
            selectedMaxValue = maxValue
            print("Min Value: \(selectedMinValue), Max Value: \(selectedMaxValue)")
        }
        
        return rangeSlider
    }
}






