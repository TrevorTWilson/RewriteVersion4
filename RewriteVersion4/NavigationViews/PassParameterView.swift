//
//  PassParameterView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-22.
//

import SwiftUI

struct PassParameterView: View {
    
    @EnvironmentObject var profile:Profile
    @ObservedObject var mainViewModel: MainViewModel
    var selectedWeldPass: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters?
    
    @State private var selectedItemForDeletion: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers.Parameters?
    @State private var showProfileView = false
    @State private var addWeldParameters = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PassParameterView_Preview: PreviewProvider {
    static var previews: some View {
        let mainViewModel = MainViewModel() // Initialize MainViewModel
        
        return PassParameterView(mainViewModel: mainViewModel)
            .environmentObject(Profile()) // Provide necessary dependencies
    }
}

