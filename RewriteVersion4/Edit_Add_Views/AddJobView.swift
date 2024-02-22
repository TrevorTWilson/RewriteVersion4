//
//  AddJobView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-15.
//

import SwiftUI
import Combine

struct AddJobView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var mainViewModel: MainViewModel
    @State private var jobName = ""
    @Binding var isPresented: Bool
    
    func addJob(){
        mainViewModel.addJob(name: jobName)
        isPresented = false
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
                    isPresented = false
                }
            }
        }
        .navigationTitle("Add New Job Item")
    }
}


struct AddJobView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isPresented: Bool = true // Define isPresented as @State variable
        AddJobView(mainViewModel: MainViewModel(), isPresented: $isPresented)
    }
}



