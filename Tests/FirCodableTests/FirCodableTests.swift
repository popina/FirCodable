import XCTest
@testable import FirCodable

final class FirDataSnapshotCodableTests: XCTestCase {
    
    func testSnapshotEncoderNotThrow() {
        let strt = StructTest(firstname: "test", lastname: "tests", age: 27)
        
        XCTAssertNoThrow(try DataSnapshotEncoder().encode(strt))
    }
    
    func testSnapshotEncoderResult() {
        let strt = StructTest(firstname: "test", lastname: "tests", age: 27)
        let dict = try? DataSnapshotEncoder().encode(strt)
        
        XCTAssertNotNil(dict)
        
        XCTAssertTrue(dict!["firstname"] as! String == "test")
        XCTAssertTrue(dict!["lastname"] as! String == "tests")
        XCTAssertTrue(dict!["age"] as! Int == 27)
    }
    
    func testSnapshotDecoderNotThrow() {
        let dict = ["firstname": "test", "lastname": "tests", "age": 27] as [String : Any]
        
        XCTAssertNoThrow(try DataSnapshotDecoder().decode(StructTest.self, value: dict))
    }
    
    func testSnapshotDecoderResult() {
        let dict = ["firstname": "test", "lastname": "tests", "age": 27] as [String : Any]
        let value = try? DataSnapshotDecoder().decode(StructTest.self, value: dict)
        
        XCTAssertNotNil(value)
        
        XCTAssertTrue(value!.firstname == dict["firstname"] as! String)
        XCTAssertTrue(value!.lastname == dict["lastname"] as! String)
        XCTAssertTrue(value!.age == dict["age"] as! Int)
    }
    
    func testEncodeDecode() {
        let dict = ["firstname": "test", "lastname": "tests", "age": 27] as [String : Any]
        
        let value = try? DataSnapshotDecoder().decode(StructTest.self, value: dict)
        
        XCTAssertNotNil(value)
        
        XCTAssertTrue(value!.firstname == dict["firstname"] as! String)
        XCTAssertTrue(value!.lastname == dict["lastname"] as! String)
        XCTAssertTrue(value!.age == dict["age"] as! Int)
        
        let dictFromValue = try? DataSnapshotEncoder().encode(value)
        
        XCTAssertNotNil(dictFromValue)
        
        XCTAssertTrue(value!.firstname == dictFromValue!["firstname"] as! String)
        XCTAssertTrue(value!.lastname == dictFromValue!["lastname"] as! String)
        XCTAssertTrue(value!.age == dictFromValue!["age"] as! Int)
        
        
        XCTAssertTrue(dictFromValue!["firstname"] as? String == dict["firstname"] as? String)
        XCTAssertTrue(dictFromValue!["lastname"] as? String == dict["lastname"] as? String)
        XCTAssertTrue(dictFromValue!["age"] as? Int == dict["age"] as? Int)
    }
}

struct StructTest: Codable {
    let firstname: String
    let lastname: String
    let age: Int
}
