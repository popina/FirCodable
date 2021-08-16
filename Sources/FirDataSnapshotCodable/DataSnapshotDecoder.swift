//
//  DataSnapshotDecoder.swift
//  
//
//  Created by Elliot Cunningham on 16/08/2021.
//

import Foundation

class DataSnapshotDecoder {
    
    public func decode<C>(_ encoder: C.Type, value: [String: Any]) throws -> C where C : Decodable {
        do {
            let data = try self.data(value)
            let someCodable = try JSONDecoder().decode(encoder, from: data)
            return someCodable
        }
        catch {
            throw error
        }
    }
    
    private func data(_ value: [String: Any]) throws -> Data {
        do {
            let data = try JSONSerialization.data(withJSONObject: value, options: .fragmentsAllowed)
            return data
        }
        catch {
            throw error
        }
    }
}
