//
//  ContentView.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-03.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var profile:Profile
    
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
                                    }, label: {
                    Text("Get Started")
                        .font(.title)
                })
//                .sheet(isPresented: $showMainMenu, content: {
//                    MainMenuView()
//                })
                
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
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    ProfileView()
        .environmentObject(Profile())
}
