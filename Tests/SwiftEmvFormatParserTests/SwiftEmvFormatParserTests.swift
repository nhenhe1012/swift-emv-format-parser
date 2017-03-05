//
//  swift_emv_format_parserTests.swift
//  swift-emv-format-parserTests
//
//  Created by Tien Nguyen on 13/6/25.
//

import Testing
@testable import SwiftEmvFormatParser

struct SwiftEmvFormatParserTests {

    @Test func testCheckSum1() async throws {
        let string = "00020101021238560010A0000007270126000697041501121133666688880208QRIBFTTA530370454067900005802VN62240820dong gop quy vac xin6304"
        #expect(EmvFormatParser().crc16CCITTHexString(from: string) == "86D1")
    }

    @Test func testCheckSum2() async throws {
        let string = "00020101021138560010A0000007270126000697043201121133666688880208QRIBFTTA53037045802VN6304"
        #expect(EmvFormatParser().crc16CCITTHexString(from: string) == "152A")
    }
    
    @Test func testQRCodeToData1() async throws {
        let string = "00020101021238560010A0000007270126000697041501121133666688880208QRIBFTTA530370454067900005802VN62240820dong gop quy vac xin630486D1"
        let valueString = "00020101021238560010A0000007270126000697041501121133666688880208QRIBFTTA530370454067900005802VN62240820dong gop quy vac xin6304"
        let data = EmvFormatParser().qrCodeToData(string)
        let checkSum = EmvFormatParser().crc16CCITTHexString(from: valueString)
        #expect(data?.checksum() == checkSum)
    }
    
    @Test func testQRCodeToData2() async throws {
        let string = "00020101021138560010A0000007270126000697043201121133666688880208QRIBFTTA53037045802VN6304152A"
        let valueString = "00020101021138560010A0000007270126000697043201121133666688880208QRIBFTTA53037045802VN6304"
        let data = EmvFormatParser().qrCodeToData(string)
        let checkSum = EmvFormatParser().crc16CCITTHexString(from: valueString)
        #expect(data?.checksum() == checkSum)
    }
    
    @Test func testQRCodeToDataWrongFormat1() async throws {
        let string = "00020101021138570010A0000007270126000697043201121133666688880208QRIBFTTA53037045802VN6304152A"
        let valueString = "00020101021138570010A0000007270126000697043201121133666688880208QRIBFTTA53037045802VN6304"
        let data = EmvFormatParser().qrCodeToData(string)
        let checkSum = EmvFormatParser().crc16CCITTHexString(from: valueString)
        #expect(data?.checksum() != checkSum)
    }
    
    @Test func testQRCodeToDataWrongFormat2() async throws {
        let string = "0002010102113850010A0000007270126000697043201121133666688880208QRIBFTTA53037045802VN6304152A"
        let valueString = "0002010102113850010A0000007270126000697043201121133666688880208QRIBFTTA53037045802VN6304"
        let data = EmvFormatParser().qrCodeToData(string)
        let checkSum = EmvFormatParser().crc16CCITTHexString(from: valueString)
        #expect(data?.checksum() != checkSum)
    }
}
