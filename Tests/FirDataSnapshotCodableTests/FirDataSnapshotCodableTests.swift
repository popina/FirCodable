import XCTest
@testable import FirDataSnapshotCodable

final class FirDataSnapshotCodableTests: XCTestCase {
    
    func testSnapshotEncoderNotThrow() {
        let strt = StructTest(firstname: "test", lastname: "tests")
        
        XCTAssertNoThrow(try DataSnapshotEncoder().encode(strt))
    }
    
    func testSnapshotEncoderResult() {
        let strt = StructTest(firstname: "test", lastname: "tests")
        let dict = try? DataSnapshotEncoder().encode(strt)
        
        XCTAssertNotNil(dict)
        
        XCTAssertTrue(dict!["firstname"] as! String == "test")
        XCTAssertTrue(dict!["lastname"] as! String == "tests")
    }
    
    func testSnapshotDecoderNotThrow() {
        let dict = ["firstname": "test", "lastname": "tests"]
        
        XCTAssertNoThrow(try DataSnapshotDecoder().decode(StructTest.self, value: dict))
    }
    
    func testSnapshotDecoderResult() {
        let dict = ["firstname": "test", "lastname": "tests"]
        let value = try? DataSnapshotDecoder().decode(StructTest.self, value: dict)
        
        XCTAssertNotNil(value)
        
        XCTAssertTrue(value!.firstname == dict["firstname"])
        XCTAssertTrue(value!.lastname == dict["lastname"])
    }
    
    func testEncodeDecode() {
        let dict = ["firstname": "test", "lastname": "tests"]
        
        let value = try? DataSnapshotDecoder().decode(StructTest.self, value: dict)
        
        XCTAssertNotNil(value)
        
        XCTAssertTrue(value!.firstname == dict["firstname"])
        XCTAssertTrue(value!.lastname == dict["lastname"])
        
        let dictFromValue = try? DataSnapshotEncoder().encode(value)
        
        XCTAssertNotNil(dictFromValue)
        
        XCTAssertTrue(value!.firstname == dictFromValue!["firstname"] as! String)
        XCTAssertTrue(value!.lastname == dictFromValue!["lastname"] as! String)
        
        
        XCTAssertTrue(dictFromValue!["firstname"] as? String == dict["firstname"])
        XCTAssertTrue(dictFromValue!["lastname"] as? String == dict["lastname"])
    }
}

struct StructTest: Codable {
    let firstname: String
    let lastname: String
}
