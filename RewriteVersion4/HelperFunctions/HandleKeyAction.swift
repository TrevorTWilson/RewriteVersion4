//
//  HandleKeyAction.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-03-08.
//


import SwiftUI

func handleKeyAction(for key: String,
                     pass: WeldingInspector.Job.WeldingProcedure.WeldPass,
                     mainViewModel: MainViewModel,
                     updateKeyValues: @escaping (String, String, Double, Double) -> Void,
                     isRangeSliderSheetPresented: Binding<Bool>) -> some View {
    
    let (selectedKey, selectedDescriptor, selectedMinRange, selectedMaxRange) = setTempValuesForKey(for: key, pass: pass)
    
    return GeometryReader { geometry in
        if pass.minRanges[key] == nil || pass.maxRanges[key] == nil {
            return Text("Add")
                .padding()
                .font(.system(size: 12))
                .frame(width: 60, height: 60)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(5)
                .onTapGesture {
                    print("Add action for key: \(key)")
                    updateKeyValues(selectedKey, selectedDescriptor, selectedMinRange, selectedMaxRange)
                    mainViewModel.setSelectedProcedurePass(weldPass: pass)
                    isRangeSliderSheetPresented.wrappedValue = true
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        } else {
            return Text("Edit")
                .padding()
                .font(.system(size: 12))
                .frame(width: 60, height: 60)
                .background(Color.green)
                .foregroundColor(.black)
                .cornerRadius(5)
                .onTapGesture {
                    print("Edit action for key: \(key)")
                    mainViewModel.setSelectedProcedurePass(weldPass: pass)
                    // Any other logic you want to perform
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
    .frame(width: 60, height: 60)
}




