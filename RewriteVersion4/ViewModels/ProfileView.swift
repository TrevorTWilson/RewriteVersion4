//
//  ProfileView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-03-18.
//

import SwiftUI

import SwiftUI

struct ProfileView: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Picker("System", selection: $mainViewModel.weldingInspector.isMetric) {
                Text("Metric").tag(true)
                Text("Imperial").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Text("Selected System: \(mainViewModel.weldingInspector.isMetric ? "Metric" : "Imperial")")
            
            Button("Close") {
                isPresented = false
        }
        .padding()
       
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMainViewModel = MainViewModel()
        mockMainViewModel.weldingInspector = loadSample()
        @State var isPresented: Bool = true
        return ProfileView(mainViewModel: mockMainViewModel, isPresented: $isPresented)
    }
}
