//
//  ButtonActionBuilder.swift
//  RewriteVersion4
//
//  Created by trevor wilson on 2024-03-01.
//

import Foundation


// Methods to return button actions to list of weld passes in WeldingProcedureFormView
// Uses Default values from getTemporaryValuesForKey in TempValuesBuilder


func addActionFor(pass: WeldingInspector.Job.WeldingProcedure.WeldPass, key: String) {
    // Use temporary values if both minRanges and maxRanges are nil
    guard let minRange = pass.minRanges[key], let maxRange = pass.maxRanges[key] else {
        let (tempMin, tempMax) = getTemporaryValuesForKey(key)
        print("Add action for \(pass.passName) - \(key) with Default minRange: \(tempMin) maxRange: \(tempMax)")
        return
    }

    // Handle the case when both minRange and maxRange are available
    print("Add action for \(pass.passName) - \(key) with UserSet minRange: \(minRange) maxRange: \(maxRange)")
}

func editActionFor(pass: WeldingInspector.Job.WeldingProcedure.WeldPass, key: String) {
    // Check if minRange and maxRange are available
    if let minRange = pass.minRanges[key], let maxRange = pass.maxRanges[key] {
        print("Edit action for \(pass.passName) - \(key) with UserSet minRange: \(minRange) maxRange: \(maxRange)")
    } else {
        let (tempMin, tempMax) = getTemporaryValuesForKey(key)
        print("Edit action for \(pass.passName) - \(key) with default minRange: \(tempMin) maxRange: \(tempMax)")
    }
}
