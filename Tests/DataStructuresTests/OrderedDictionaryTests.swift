import XCTest
import SwiftAlgorithmClub
@testable import DataStructures

struct TestStruct: Equatable {
    let value: String
}

final class OrderedDictionaryTests: XCTestCase {
    func testEmptyOrderedDictionary() {
        let od = OrderedDictionary<String, Int>(allowDuplicates: false)
        XCTAssertEqual(od.count, 0)
        XCTAssertEqual(0, od.keys.count)
        XCTAssertEqual(od.values, [:])
    }

    func testOrderedDictionaryElements() {
        var od = OrderedDictionary<Date, String>(allowDuplicates: false)
        let now = Date(timeIntervalSinceReferenceDate: 0)
    }
    
    func testAddOrderedDictionaryElements() {
        var od = OrderedDictionary<String, Int>(allowDuplicates: false)
        od["foo"] = 1
        od["bar"] = 2
        
        XCTAssertEqual(od.count, 2)
        
        // Lookup by key
        XCTAssertEqual(1, od["foo"])
        XCTAssertEqual(2, od["bar"])
        XCTAssertEqual(od.keys, ["bar", "foo"])
        
        // Lookup by index
        XCTAssertEqual(2, od[0])
        XCTAssertEqual(1, od[1])
    }
    
    func testDeleteOrderedDictionaryElement() {
        var od = OrderedDictionary<String, Int>(allowDuplicates: false)
        
        od["foo"] = 1
        od["foo"] = nil
        
        XCTAssertEqual(od.count, 0)
        XCTAssertEqual(od["foo"], nil)
    }
    
    func testOrderDictionaryTemporal() {
        var orderedDict = OrderedDictionary<Date, TestStruct>(allowDuplicates: false)
        let now = Date()
        let structNow = TestStruct(value: "now")
        orderedDict[now] = structNow
        let nowMinusOneSec = now.addingTimeInterval(-1)
        let structNowMinusOneSec = TestStruct(value: "one second in the past from now")
        orderedDict[nowMinusOneSec] = structNowMinusOneSec
        XCTAssertEqual(structNowMinusOneSec, orderedDict[0])
        XCTAssertEqual(structNow, orderedDict[1])
    }

    static var allTests = [
        ("testEmptyOrderedDictionary", testEmptyOrderedDictionary),
        ("testAddOrderedDictionaryElements", testAddOrderedDictionaryElements),
        ("testDeleteOrderedDictionaryElement", testDeleteOrderedDictionaryElement),
        ("testOrderDictionaryTemporal", testOrderDictionaryTemporal),
    ]
}
