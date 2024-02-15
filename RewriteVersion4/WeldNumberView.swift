//
//  WeldNumberView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI

struct WelderNumberView: View {
    
    @EnvironmentObject var profile:Profile
    @ObservedObject var mainViewModel: MainViewModel
    var selectedJob: WeldingInspector.Job?
    var selectedProcedure: WeldingInspector.Job.WeldingProcedure?
    var selectedWelder: WeldingInspector.Job.WeldingProcedure.Welder?
    

    @State private var showProfileView = false
    @State private var addNewWeldNumber = false
    
        var body: some View {
            VStack{
                // Rendering the view based on selected procedure
                Text("Selected Procedure: \(selectedWelder?.name  ?? "None")")
            }
            .onAppear(perform: {
                mainViewModel.selectedWelder = selectedWelder
                if let selectedWelderName = mainViewModel.selectedWelder?.name {
                    print("Selected welder name is \(selectedWelderName)")
                } else {
                    print("No welder selected")
                }
    
            })
        }
}
