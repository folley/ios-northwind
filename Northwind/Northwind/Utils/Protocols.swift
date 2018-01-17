//
//  Protocols.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//

import Foundation

protocol PickerModelDescription: class {
    
    static func pickerConfiguration() -> PickerConfiguration
    
}

protocol EditableItemConfiguration: class {
    associatedtype T
    static func editConfigurationItems() -> [ItemEditConfiguration<T>.Item]
}

