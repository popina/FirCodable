//
//  DataSnapshotEncoder.swift
//  
//
//  Created by Elliot Cunningham on 16/08/2021.
//

import Foundation

public class DataSnapshotEncoder {
    
    public init() {
        
    }
    
    public func encode<C: Encodable>(_ value: C) throws -> [String: Any] {
        do {
            let data = try self.data(value)
            let dict = try self.dict(data)
            
            return dict
        }
        catch {
            throw error
        }
    }
    
    private func data<C: Encodable>(_ value: C) throws -> Data {
        do {
            let data = try JSONEncoder().encode(value)
            return data
        }
        catch {
            throw error
        }
    }
    
    private func dict(_ value: Data) throws -> [String: Any] {
        do {
            let dict = try JSONSerialization.jsonObject(with: value, options: .fragmentsAllowed)
            return dict as! [String: Any]
        }
        catch {
            throw error
        }
    }
}
