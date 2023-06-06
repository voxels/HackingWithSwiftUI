//
//  ChallengeOneView.swift
//  HackingWIthSwiftUI
//
//  Created by Michael A Edgcumbe on 6/6/23.
//

import SwiftUI

struct ChallengeOneView: View {
    @State private var value:Double = 0
    @State private var fromUnit:PickerView.Units = .feet
    @State private var toUnit:PickerView.Units = .miles
    
    var convertedValue:Double {
        var fromUnitLength = UnitLength.feet
        var toUnitLength = UnitLength.miles
        switch fromUnit {
        case .feet:
            // do nothing
            break
        case .miles:
            fromUnitLength = UnitLength.miles
        case .kilometers:
            fromUnitLength = UnitLength.kilometers
        }
        
        switch toUnit {
        case .feet:
            toUnitLength = .feet
        case .miles:
            break
        case .kilometers:
            toUnitLength = .kilometers
        }
        
        var measurement = Measurement(value: value, unit: fromUnitLength)
        
        return measurement.converted(to: toUnitLength).value
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount to convert", value: $value, format: .number)
                } header: {
                    Text("Amount")
                }
                Section {
                    PickerView(titleString: "Convert From", unit: $fromUnit)
                } header: {
                    Text("Convert from")
                }
                Section{
                    PickerView(titleString: "To", unit: $toUnit)
                } header: {
                    Text("to units")
                }
                Section{
                    Text("Converting \(value) from \(fromUnit.rawValue) to \(toUnit.rawValue): \(convertedValue)")
                }
            }
        }
    }
}

struct PickerView : View {
    @State private var titleString:String
    @Binding var unit:Units

    enum Units:String, CaseIterable, Identifiable {
        case feet, miles, kilometers
        var id: Self { self }
    }
    
    init(titleString: String, unit: Binding<Units>) {
        self.titleString = titleString
        _unit = unit
    }
    
    var body: some View {
        Picker(titleString, selection: $unit) {
            Text("Feet").tag(Units.feet)
            Text("Miles").tag(Units.miles)
            Text("Kilometers").tag(Units.kilometers)
        }.pickerStyle(.segmented)
    }
}

struct ChallengeOneView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeOneView()
    }
}
