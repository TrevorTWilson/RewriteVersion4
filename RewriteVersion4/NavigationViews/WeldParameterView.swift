//
//  WeldParameterView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI

struct WeldParameterView: View {
    
    @EnvironmentObject var profile:Profile
    @ObservedObject var mainViewModel: MainViewModel
    var selectedJob: WeldingInspector.Job?
  
    var selectedProcedure: WeldingInspector.Job.WeldingProcedure?

    var selectedWelder: WeldingInspector.Job.WeldingProcedure.Welder?
 
    
    @State private var selectedItemForDeletion: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters?
    @State private var showProfileView = false
    @State private var addWeldParameters = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}



// .onDelete code for future use
//    .onDelete { indexSet in
//        if let index = indexSet.first {
//            selectedItemForDeletion = mainViewModel.weldingInspector.jobs[selectedJobIndex].weldingProcedures[selectedProcedureIndex].weldersQualified[selectedWelderIndex].welds[index]
//        }
//    }


//#Preview {
//    WeldParameterView()
//}
