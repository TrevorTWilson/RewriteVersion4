//
//  TwoHandleSlider.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-02-23.
//

import SwiftUI

import SwiftUI

struct ContentView : View {
    @State var leftHandleViewState = CGSize.zero
    @State var rightHandleViewState = CGSize.zero
    var body: some View {
        let leftHandleDragGesture = DragGesture(minimumDistance: 1, coordinateSpace: .local)
            .onChanged { value in
                guard value.location.x >= 0 else {
                    return
                }
                self.leftHandleViewState.width = value.location.x
                print(value)
        }
        let rightHandleDragGesture = DragGesture(minimumDistance: 1, coordinateSpace: .local)
            .onChanged { value in
                guard value.location.x <= 0 else {
                    return
                }
                self.rightHandleViewState.width = value.location.x
        }
        return HStack(spacing: 0) {
            Circle()
                .fill(Color.yellow)
                .frame(width: 24, height: 24, alignment: .center)
                .offset(x: leftHandleViewState.width, y: 0)
                .gesture(leftHandleDragGesture)
                .zIndex(1)
            Rectangle()
                .frame(width: CGFloat(300.0), height: CGFloat(1.0), alignment: .center)
                .zIndex(0)
            Circle()
                .fill(Color.yellow)
                .frame(width: 24, height: 24, alignment: .center)
                .offset(x: rightHandleViewState.width, y: 0)
                .gesture(rightHandleDragGesture)
                .zIndex(1)
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
