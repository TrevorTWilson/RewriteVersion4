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
    
    var body: some View {
        Form {
            TextField("New Job Name", text: $jobName)
            HStack{
                Button("Add Item") {
                    mainViewModel.addJob(name: jobName)
                    dismiss()
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




