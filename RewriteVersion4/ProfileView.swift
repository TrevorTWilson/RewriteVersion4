//
//  ContentView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-03.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var profile:Profile
    @Environment(\.dismiss) var dismiss
    @Binding var weldingInspector: WeldingInspector?
    
    var body: some View {
        VStack {
            if profile.isLoggedIn == true {
                
                Text("Hello and welcome back!")
                
                if profile.isMetric == true {
                    Text("Units used will be Metric")
                } else {
                    Text("Units used will be Imperial")
                }
                
                HStack{
                    Button(action: {
                        if let weldingInspector = self.weldingInspector {
                            StorageFunctions.storeInspector(weldingInspector: weldingInspector)
                        }
                        profile.isLoggedIn = false
                    }, label: {
                        Text("Log Out")
                    })

                    Button(action: {
                        profile.isMetric.toggle()
                    }, label: {
                        Text("Change Units")
                    })
                }
                
                Button(action: {
                    weldingInspector = StorageFunctions.retrieveInspector()
                    dismiss()
                                    }, label: {
                    Text("Get Started")
                        .font(.title)
                })
            } else {
                
                Text("Please Log In")
                Button(action: {
                    profile.isLoggedIn = true
                    self.weldingInspector = StorageFunctions.retrieveInspector()
                }, label: {
                    Text("Log In")
                })
            }
        }
        .padding()
        .buttonStyle(.borderedProminent)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(weldingInspector: .constant(nil))
            .environmentObject(Profile())
    }
}
 
