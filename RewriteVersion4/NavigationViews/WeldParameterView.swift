//
//  WeldParameterView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI
import Combine

struct WeldParameterView: View {
    
    @EnvironmentObject var profile:Profile
    @ObservedObject var mainViewModel: MainViewModel
    //var selectedJob: WeldingInspector.Job?
    
    //var selectedProcedure: WeldingInspector.Job.WeldingProcedure?
    
    //var selectedWelder: WeldingInspector.Job.WeldingProcedure.Welder?
    
    var selectedWeldNumber: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers?
    var selectedWeldNumberParameters: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters?
    
    @State private var selectedItemForDeletion: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters?
    @State private var showProfileView = false
    @State private var addWeldParameters = false
    
    
    func output<T>(_ data: T) {
        print(data)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("Parameters Collected")
                        .font(.title)
                    Spacer()
                    // Add new item to list of jobs
                    Button {
                        addWeldParameters = true
                    }label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
                HStack{
                    Text("Current Job: ")
                    Spacer()
                    Text(mainViewModel.selectedJob?.name ?? "Title")
                }
                HStack{
                    Text("Current Procedure: ")
                    Spacer()
                    Text(mainViewModel.selectedWeldingProcedure?.name ?? "Title")
                }
                HStack{
                    Text("Current Welder: ")
                    Spacer()
                    Text(mainViewModel.selectedWelder?.name ?? "Title")
                }
                HStack{
                    Text("Current Weld Number: ")
                    Spacer()
                    Text(mainViewModel.selectedWeldNumber?.name ?? "Number")
                }
                Spacer()

                // Define the keys in the desired order
                let orderedKeys = ["Amps", "Volts", "ArcSpeed", "HeatInput"]

                // Iterate over collectedParameters stored in the weldNumber
//                if let parametersArray = mainViewModel.selectedWeldNumberParameters {
//                    ForEach(parametersArray, id: \.id) { parameters in
//                        Text("Pass Name: \(parameters.passName)")
//
//                        ForEach(orderedKeys, id: \.self) { key in
//                            if let value = parameters.collectedValues[key] {
//                                KeyValueView(key: key, value: value)
//                            }
//                        }
//                    }
//                } else {
//                    Text("No Parameters Collected")
//                }
            }
            .onAppear{
                mainViewModel.selectedWeldNumber = selectedWeldNumber
//                if let weldParameters = mainViewModel.selectedWeldNumber?.parametersCollected{
//                    mainViewModel.selectedWeldNumberParameters = weldParameters
//                }
            }
            .sheet(isPresented: $addWeldParameters, content: {
                // Add new job item view
                AddParametersView(mainViewModel: mainViewModel)
            })
        }
    }
}






struct WeldParameterView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMainViewModel = MainViewModel()
        mockMainViewModel.weldingInspector = loadSample() // Initialize with default data or mock data

        return WeldParameterView(mainViewModel: mockMainViewModel, 
                                 selectedWeldNumber: mockMainViewModel.weldingInspector.jobs[1].weldingProcedures[0].weldersQualified[0].welds[0], selectedWeldNumberParameters: mockMainViewModel.weldingInspector.jobs[1].weldingProcedures[0].weldersQualified[0].welds[0].parametersCollected[0])
            .environmentObject(Profile())
    }
}

