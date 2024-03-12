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
    
    @State private var elapsedTime: TimeInterval?
    @State private var ampSliderValue: Double = 0.0
    @State private var voltSliderValue: Double = 0.0
    @State private var distanceSliderValue: Double = 0.0
    @State private var formattedElapsedTime: Double = 0.0
    
    @Binding var isPresented: Bool
    var selectedProcedureWeldPass: WeldingInspector.Job.WeldingProcedure.WeldPass?
    
    init(mainViewModel: MainViewModel, isPresented: Binding<Bool>) {
        self.mainViewModel = mainViewModel
        self._isPresented = isPresented
        self.selectedProcedureWeldPass = mainViewModel.selectedWeldingProcedure?.weldPass.first
    }

   
    

    var body: some View {
        
        if selectedProcedureWeldPass != nil {
            let ampMinimunSliderValue = Double(selectedProcedureWeldPass?.minRanges["Amps"] ?? 0.0)

            }
        
        let amps = CircleSliderVC(minimunSliderValue: 50, maximunSliderValue: 300, totalValue: 300, knobRadius: 15, radius: 75, initialSliderValue: 35, valueUnit: "Amps", sliderValue: $ampSliderValue)
        
        let volts = CircleSliderVC(minimunSliderValue: 8, maximunSliderValue: 40, totalValue: 40, knobRadius: 15, radius: 75, initialSliderValue: 15, valueUnit: "Volts", sliderValue: $voltSliderValue)
        
        let distance = CircleSliderVC(minimunSliderValue: 50, maximunSliderValue: 400, totalValue: 400, knobRadius: 15, radius: 75, initialSliderValue: 185, valueUnit: "mm", sliderValue: $distanceSliderValue)
        
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
                    Text("Amp Value: \(String(format: "%.1f", ampSliderValue))")
                    Text("Volt Value: \(String(format: "%.1f", voltSliderValue))")
                    Text("Distance Value: \(String(format: "%.1f", distanceSliderValue))")
                }
                    .foregroundStyle(Color.white)
            }
        }
        .onChange(of: elapsedTime) {
            formattedElapsedTime = convertElapsedTimeToNearestSecond()
        }

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
