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
    var selectedJobIndex: Int
    var selectedProcedure: WeldingInspector.Job.WeldingProcedure?
    var selectedProcedureIndex: Int
    var selectedWelder: WeldingInspector.Job.WeldingProcedure.Welder?
    var selectedWelderIndex: Int
    
    
    @State private var showProfileView = false
    @State private var addNewWeldNumber = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//#Preview {
//    WeldParameterView()
//}
