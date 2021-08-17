import Foundation
import FirebaseDatabase

public extension DatabaseReference {
    func observe<C: Codable>(_ type: DataEventType, completion: @escaping(_ value: C?, _ error: Error?) -> Void) {
        self.observe(type) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else {
                let error = NSError(domain: "Codable", code: 0, userInfo: [NSLocalizedDescriptionKey: "snapshot value not conform to Codable protocol"])
                completion(nil, error)
                return
            }
            
            do {
                let value = try DataSnapshotDecoder().decode(C.self, value: dict)
                completion(value, nil)
            }
            catch {
                completion(nil, error)
            }
        }
        
        
    }
    
    func observeSingleEvent<C: Codable>(_ type: DataEventType, completion: @escaping(_ value: C?, _ error: Error?) -> Void) {
        self.observeSingleEvent(of: type) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else {
                let error = NSError(domain: "Codable", code: 0, userInfo: [NSLocalizedDescriptionKey: "snapshot value not conform to Codable protocol"])
                completion(nil, error)
                return
            }
            
            do {
                let value = try DataSnapshotDecoder().decode(C.self, value: dict)
                completion(value, nil)
            }
            catch {
                completion(nil, error)
            }
        }
    }
}
