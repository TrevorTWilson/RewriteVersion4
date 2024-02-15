//
//  WelderView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI

struct WelderView: View {
    
    @EnvironmentObject var profile:Profile
    @ObservedObject var mainViewModel: MainViewModel
    var selectedJob: WeldingInspector.Job?
    var selectedProcedure: WeldingInspector.Job.WeldingProcedure?
    

    @State private var showProfileView = false
    @State private var addNewProcedure = false
    
        var body: some View {
            VStack{
                // Rendering the view based on selected procedure
                Text("Selected Procedure: \(selectedProcedure?.name  ?? "None")")
            }
            .onAppear(perform: {
                mainViewModel.selectedWeldingProcedure = selectedProcedure
                if let selectedProcedureName = mainViewModel.selectedWeldingProcedure?.name {
                    print("Selected Procedure name is \(selectedProcedureName)")
                } else {
                    print("No procedure selected")
                }
    
            })
        }
}

//#Preview {
//    WelderView()
//}
