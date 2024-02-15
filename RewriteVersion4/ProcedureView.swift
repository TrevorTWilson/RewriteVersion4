//
//  ProcedureView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-13.
//

import SwiftUI

struct ProcedureView: View {
    @EnvironmentObject var profile:Profile
    @ObservedObject var mainViewModel: MainViewModel
    var selectedJob: WeldingInspector.Job?
    var selectedJobIndex: Int

    @State private var showProfileView = false
    @State private var addNewProcedure = false
    
//    var body: some View {
//        VStack{
//            // Rendering the view based on selected job
//            Text("Selected Job: \(selectedJob?.name  ?? "None")")
//        }
//        .onAppear(perform: {
//            mainViewModel.selectedJob = selectedJob
//            if let selectedJobName = mainViewModel.selectedJob?.name {
//                print("Selected Job name is \(selectedJobName)")
//            } else {
//                print("No job selected")
//            }
//            
//        })
//    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("Current Job: ")
                    Text(selectedJob?.name ?? "Title")
                }
                HStack{
                    Text("Select a Procedure")
                        .font(.title)
                    Spacer()
                    // Add new item to list of jobs
                    Button {
                        addNewProcedure = true
                    }label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
                Spacer()
                // Iterate through list of procedures in instance of WeldingInspector for navigation list of each
                List {
                    if let weldingProcedures = selectedJob?.weldingProcedures, !weldingProcedures.isEmpty {
                        ForEach(weldingProcedures) { procedure in
                            NavigationLink(destination: WelderView(mainViewModel: mainViewModel, selectedJob: selectedJob, selectedProcedure: procedure)) {
                                Text(procedure.name)
                            }
                        }
                        .onDelete { indexSet in
                            mainViewModel.deleteSelectedProcedure(index: indexSet, jobIndex: selectedJobIndex)
                        }
                    } else {
                        Text("No welding procedures available")
                        Text("Add welding procedures to the selected Job")
                    }
                }



                
            }

            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showProfileView = true
                        
                    }) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $showProfileView) {
                //ProfileView(weldingInspector: weldingInspector)
                
            }
            .sheet(isPresented: $addNewProcedure, content: {
                // Add new job item view
                EmptyView()
            })
        }
    }
    
}




//#Preview {
//    ProcedureView()
//}
