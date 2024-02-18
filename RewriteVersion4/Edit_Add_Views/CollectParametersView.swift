//
//  CollectParametersView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-18.
//

import SwiftUI

struct CollectParametersView: View {
    var body: some View {
        
        let amps = CircleSliderVC(minimunSliderValue: 50, maximunSliderValue: 300, minimunRange: 100, maximunRange: 200, totalValue: 300, knobRadius: 15, radius: 75, initialSliderValue: 35, valueUnit: "Amps")
        
        let volts = CircleSliderVC(minimunSliderValue: 8, maximunSliderValue: 40, minimunRange: 100, maximunRange: 200, totalValue: 40, knobRadius: 15, radius: 75, initialSliderValue: 15, valueUnit: "Volts")
        
        let distance = CircleSliderVC(minimunSliderValue: 50, maximunSliderValue: 400, minimunRange: 50, maximunRange: 400, totalValue: 400, knobRadius: 15, radius: 75, initialSliderValue: 185, valueUnit: "mm")
        
        let time = CircleSliderVC(minimunSliderValue: 0, maximunSliderValue: 150, minimunRange: 10, maximunRange: 150, totalValue: 150, knobRadius: 15, radius: 75, initialSliderValue: 35, valueUnit: "secs")
        
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
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollectParametersView()
    }
}
