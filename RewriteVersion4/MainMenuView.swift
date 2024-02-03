//
//  MainMenu.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-03.
//

import SwiftUI

struct MainMenuView: View {
    
    @EnvironmentObject var profile:Profile
    @State private var showProfileView = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, World!")
                    .navigationTitle("Main Menu")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showProfileView = true
                            }) {
                                Image(systemName: "gear")
                                    .imageScale(.large)
                            }
                        }
                    }
            }
            .sheet(isPresented: $showProfileView) {
                ProfileView()
            }
        }
    }
}




#Preview {
    MainMenuView()
        .environmentObject(Profile())
}
