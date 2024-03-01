//
//  WeldParameterView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI
import Combine

struct WeldPassView: View {
    
    @EnvironmentObject var profile:Profile
    @ObservedObject var mainViewModel: MainViewModel
    
    var selectedWeldNumber: WeldingInspector.Job.WeldingProcedure.Welder.WeldNumbers?
    
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

                // Iterate over collectedParameters stored in the weldNumber data Model
                List {
                    if let passParameter = selectedWeldNumber?.parametersCollected, !passParameter.isEmpty {
                        ForEach(Array(passParameter.enumerated()), id: \.element.id) { index, pass in
                            NavigationLink(destination: PassParameterView(mainViewModel: mainViewModel, selectedWeldPass: pass)) {
                                Text(pass.passName)
                            }
                            .contextMenu {
                                Button(action: {
                                    // Edit action
                                    // Implement editing functionality here
                                }) {
                                    Label("Edit", systemImage: "pencil")
                                }
                                
                                Button(action: {
                                    // Delete action
                                    selectedItemForDeletion = mainViewModel.selectedWeldNumber?.parametersCollected[index]
                                }) {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        .onDelete { indexSet in
                            if let index = indexSet.first {
                                selectedItemForDeletion = mainViewModel.selectedWeldNumber?.parametersCollected[index]
                            }
                        }
                    } else {
                        Text("No passes available")
                        Text("Add weld pass to list of collected parameters")
                    }
                }
            }
            .onAppear{
                if selectedWeldNumber != nil {
                    mainViewModel.setSelectedWeldNumber(weldId: selectedWeldNumber!)
                }
            }
            .alert(item: $selectedItemForDeletion) { pass in
                Alert(
                    title: Text("Delete Weld Pass"),
                    message: Text("Are you sure you want to delete \(pass.passName)? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        if let index = mainViewModel.selectedWeldNumber?.parametersCollected.firstIndex(where: { $0.id == pass.id }) {
                            mainViewModel.deleteSelectedWeldPass(index: index)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .sheet(isPresented: $addWeldParameters, content: {
                // Add new job item view
                AddParametersView(mainViewModel: mainViewModel, isPresented: $addWeldParameters)
            })
        }
    }
}






struct WeldParameterView_Previews: PreviewProvider {
    static var previews: some View {
        let mockMainViewModel = MainViewModel()
        mockMainViewModel.weldingInspector = loadSample() // Initialize with default data or mock data

        return WeldPassView(mainViewModel: mockMainViewModel, 
                                 selectedWeldNumber: mockMainViewModel.weldingInspector.jobs[1].weldingProcedures[0].weldersQualified[0].welds[0])
            .environmentObject(Profile())
    }
}

