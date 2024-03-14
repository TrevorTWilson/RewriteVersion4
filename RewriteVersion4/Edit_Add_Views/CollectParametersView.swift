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
    
    @State private var ampMinRange: Double = 0.0
    @State private var ampMaxRange: Double = 0.0
    @State private var voltMinRange: Double = 0.0
    @State private var voltMaxRange: Double = 0.0
    @State private var arcSpeedMinRange: Double = 0.0
    @State private var arcSpeedMaxRange: Double = 0.0
    @State private var heatInputMinRange: Double = 0.0
    @State private var heatInputMaxRange: Double = 0.0

    
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
        if let collectedValues = selectedWeldPass?.collectedValues, let passRange = selectedWeldPass?.procedurePass{
            let orderedKeys = ["Amps", "Volts", "Distance", "Time", "ArcSpeed", "HeatInput"]
            for key in orderedKeys {
                if let value = collectedValues[key], let minRanges = passRange.minRanges[key], let maxRanges = passRange.maxRanges[key] {
                    print("\(key)----Value: \(value)---minRange: \(minRanges)---maxRange: \(maxRanges)")
                    switch key {
                    case "Amps":
                        print("Set Amps")
                        self._ampSliderValue = State(initialValue: value)
                        self._ampMinRange = State(initialValue: minRanges)
                        self._ampMaxRange = State(initialValue: maxRanges)
                    case "Volts":
                        print("Set Volts")
                        self._voltSliderValue = State(initialValue: value)
                        self._voltMinRange = State(initialValue: minRanges)
                        self._voltMaxRange = State(initialValue: maxRanges)
                    case "Distance":
                        print("Set Distance")
                        self._distanceSliderValue = State(initialValue: value)
                    case "ArcSpeed":
                        print("Set ArcSpeed")
                        self._arcSpeedMinRange = State(initialValue: minRanges)
                    case "HeatInput":
                        print("Set HeatInput")
                        self._heatInputMaxRange = State(initialValue: maxRanges)
                    case "Time":
                        print("Set Elapsed Time")
                        self._elapsedTime = State(initialValue: value)
                    default:
                        print("Broke out of switch case")
                        break
                    }
                } else {
                    print("Broke out of for key loop")
                }
                
            }
        } else {
            print("CollectedValues or PassRange failed")
        }
        
    }
    
    
    var body: some View {
        
        
        let amps = CircleSliderVC(minimunSliderValue: 0, maximunSliderValue: 300,minimumSliderRange: ampMinRange, maximumSliderRange: ampMaxRange, knobRadius: 15, radius: 75, valueUnit: "Amps", sliderValue: $ampSliderValue)
        
        let volts = CircleSliderVC(minimunSliderValue: 0, maximunSliderValue: 40,minimumSliderRange: voltMinRange, maximumSliderRange: voltMaxRange, knobRadius: 15, radius: 75, valueUnit: "Volts", sliderValue: $voltSliderValue)
        
        let distance = CircleSliderVC(minimunSliderValue: 0, maximunSliderValue: 400, minimumSliderRange: 0, maximumSliderRange: 400, knobRadius: 15, radius: 75, valueUnit: "mm", sliderValue: $distanceSliderValue)
        
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




