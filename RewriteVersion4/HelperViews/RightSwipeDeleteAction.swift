//
//  RightSwipeDeleteAction.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-03-09.
//

import SwiftUI

struct RightSwipeDeleteAction: View {
    var action: () -> Void

    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                Button(action: action) {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .clipShape(Circle())
                }
            }
            .frame(width: geometry.size.width)
        }
    }
}


//#Preview {
//    RightSwipeDeleteAction()
//}
