//
//  CollectParametersView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-18.
//

import SwiftUI
import Combine

struct CollectParametersView: View {
    
    @EnvironmentObject var profile:Profile
    @ObservedObject var mainViewModel: MainViewModel
    
    var selectedWeldPass: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters?
    
    @State private var elapsedTime: TimeInterval?
    @State private var ampSliderValue: Double = 0.0
    @State private var voltSliderValue: Double = 0.0
    @State private var distanceSliderValue: Double = 0.0
    @State private var formattedElapsedTime: Double = 0.0
    @State private var formattedAmpSlider: Double = 0.0
    @State private var formattedDistanceSlider: Double = 0.0
    @State private var arcSpeed: Double = 0.0
    @State private var heatInput: Double = 0.0
    @State private var dataChangeTrigger = UUID()
    
    @State private var initialAmpValue: Double = 0.0
    @State private var initialVoltValue: Double = 0.0
    @State private var initialDistanceValue: Double = 0.0
    @State private var initialTimeValue: Double = 0.0
    
    // Define the keys in the desired order
    // let orderedKeys = ["Amps", "Volts", "Distance", "Time"]
    
    var dataChangeTriggers: [UUID] {
        return [
            dataChangeTrigger,
            UUID()
        ]
    }
    
    @Binding var isPresented: Bool

    
    init(mainViewModel: MainViewModel, isPresented: Binding<Bool>) {
        self.mainViewModel = mainViewModel
        self._isPresented = isPresented
        self.selectedWeldPass = mainViewModel.selectedWeldPass
        // Set initial values for Sliders and StopWatch
        if let collectedValues = selectedWeldPass?.collectedValues{
            let orderedKeys = ["Amps", "Volts", "Distance", "Time"]
            for key in orderedKeys {
                if let value = collectedValues[key] {
                    switch key {
                    case "Amps":
                        self._initialAmpValue = State(initialValue: value)
                    case "Volts":
                        self._initialVoltValue = State(initialValue: value)
                    case "Distance":
                        self._initialDistanceValue = State(initialValue: value)
                    case "Time":
                        self._elapsedTime = State(initialValue: value)
                    default:
                        break
                    }
                }
            }
        }
    }
    
    
    var body: some View {
        
        
        let amps = CircleSliderVC(minimunSliderValue: 0, maximunSliderValue: 300, totalValue: 300, knobRadius: 15, radius: 75, initialSliderValue: initialAmpValue, valueUnit: "Amps", sliderValue: $ampSliderValue)
        
        let volts = CircleSliderVC(minimunSliderValue: 0, maximunSliderValue: 40, totalValue: 40, knobRadius: 15, radius: 75, initialSliderValue: initialVoltValue, valueUnit: "Volts", sliderValue: $voltSliderValue)
        
        let distance = CircleSliderVC(minimunSliderValue: 0, maximunSliderValue: 400, totalValue: 400, knobRadius: 15, radius: 75, initialSliderValue: initialDistanceValue, valueUnit: "mm", sliderValue: $distanceSliderValue)
        
        let time = RoundStopwatchView(elapsedTime: $elapsedTime)
        
        ZStack {
            Rectangle()
                .fill(Color.init(red: 34/255, green: 30/255, blue: 47/255))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    amps
                    Spacer()
                    volts
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    distance
                    Spacer()
                    time
                    Spacer()
                }
                Spacer()
                VStack {
                    Text("Formatted Elapsed Time: \(String(format: "%.1f", formattedElapsedTime))")
                    Text("Amp Value: \(String(format: "%.1f", formattedAmpSlider))")
                    Text("Volt Value: \(String(format: "%.1f", voltSliderValue))")
                    Text("Distance Value: \(String(format: "%.1f", formattedDistanceSlider))")
                    Text("ArcSpeed Value: \(String(format: "%.1f", arcSpeed))")
                    Text("HeatInput Value: \(String(format: "%.1f", heatInput))")
                }
                .foregroundStyle(Color.white)
            }
        }
        .onChange(of: dataChangeTriggers) {
            updateFormattedValues()
        }
        
    }
    
    func updateFormattedValues() {
        formattedElapsedTime = convertElapsedTimeToNearestSecond()
        formattedAmpSlider = convertSliderValue(sliderValue: ampSliderValue)
        formattedDistanceSlider = convertSliderValue(sliderValue: distanceSliderValue)
        arcSpeed = calculateArcSpeed(distance: formattedDistanceSlider, time: formattedElapsedTime)
        heatInput = calculateHeatInput(distance: formattedDistanceSlider, time: formattedElapsedTime, amps: formattedAmpSlider, volts: voltSliderValue)
    }
    
    func convertSliderValue(sliderValue: Double) -> Double {
        let roundedSliderValue = round(sliderValue)
        return roundedSliderValue
    }
    
    
    func convertElapsedTimeToNearestSecond() -> Double {
        if let elapsedTime = elapsedTime {
            // Convert TimeInterval to Double and round to the nearest second
            let doubleElapsedTime = Double(elapsedTime)
            let roundedElapsedTime = round(doubleElapsedTime) // Round to the nearest second
            return roundedElapsedTime
        } else {
            // Default value if elapsedTime is nil
            return 0.0
        }
    }
}


struct CollectParametersView_Previews: PreviewProvider {
    @State static var isPresented: Bool = true
    
    static var previews: some View {
        CollectParametersView(mainViewModel: MainViewModel(), isPresented: $isPresented)
    }
}
