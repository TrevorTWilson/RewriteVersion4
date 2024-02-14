//
//  ProcedureView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-13.
//

import SwiftUI

struct ProcedureView: View {
    @ObservedObject var mainViewModel: MainViewModel
    var selectedJob: WeldingInspector.Job?

//    init(mainViewModel: MainViewModel, selectedJob: WeldingInspector.Job) {
//        self.mainViewModel = mainViewModel
//        self.selectedJob = selectedJob
//    }

//    func setUpSelectedJob(){
//        mainViewModel.setSelectedJob(selectedJob)
//    }
    
    var body: some View {
        VStack{
            // Rendering the view based on selected job
            Text("Selected Job: \(selectedJob?.name  ?? "None")")
        }
        .onAppear(perform: {
            mainViewModel.selectedJob = selectedJob
            //print(mainViewModel.selectedJob?.name as Any)
            if let selectedJobName = mainViewModel.selectedJob?.name {
                print("Selected Job name is \(selectedJobName)")
            } else {
                print("No job selected")
            }
            
        })
    }
}




//#Preview {
//    ProcedureView()
//}
