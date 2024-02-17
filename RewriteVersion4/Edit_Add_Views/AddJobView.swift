//
//  AddJobView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI

struct AddJobView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    @State private var jobName = ""
    
    func addJob(){
        mainViewModel.addJob(name: jobName)
        dismiss()
    }
    
    var body: some View {
        Form {
            TextField("New Job Name", text: $jobName)
                .onSubmit {
                    addJob()
                }
            HStack{
                Button("Add Item") {
                    addJob()
                }
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .navigationTitle("Add New Job Item")
    }
}




