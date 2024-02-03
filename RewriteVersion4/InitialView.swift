//
//  ContentView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-03.
//

import SwiftUI

struct InitialView: View {
    
    @EnvironmentObject var profile:Profile
    
    var body: some View {
        VStack {
            if profile.isLoggedIn == true {
                
                Text("Hello and welcome back!")
                Button(action: {
                    profile.isLoggedIn = false
                }, label: {
                    Text("Log Out")
                })
                
            } else {
                
                Text("Please Log In")
                Button(action: {
                    profile.isLoggedIn = true
                }, label: {
                    Text("Log In")
                })
            }
        }
        .padding()
    }
}

#Preview {
    InitialView()
        .environmentObject(Profile())
}
