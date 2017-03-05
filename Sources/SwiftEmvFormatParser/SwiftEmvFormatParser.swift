//
//  swift_emv_format_parser.swift
//  swift-emv-format-parser
//
//  Created by Tien Nguyen on 13/6/25.
//

import Foundation

public struct EmvFormatParser {
    
    public init() { }
    
    public func qrCodeToData(_ qrCode: String) -> EmvData? {
        var data = EmvData(array: [])
        var qrCodeData = qrCode
        
        while !qrCodeData.isEmpty {
            if qrCodeData.count < 2 { return nil }
            let idString = "\(qrCodeData.removeFirst())\(qrCodeData.removeFirst())"
            guard let _ = Int(idString) else { return nil }
            if qrCodeData.count < 2 { return nil }
            let lengthString = "\(qrCodeData.removeFirst())\(qrCodeData.removeFirst())"
            if let length = Int(lengthString) {
                var valueString = ""
                for _ in 0..<length {
                    if !qrCodeData.isEmpty {
                        valueString.append(qrCodeData.removeFirst())
                    }
                }
                let node = EmvObject(id: idString, length: length, value: valueString, array: qrCodeToData(valueString)?.array ?? [])
                data.array.append(node)
            }
        }
        return data
    }
    
    func crc16CCITTHexString(
        from input: String,
        poly: UInt16 = 0x1021,
        initial: UInt16 = 0xFFFF
    ) -> String {
        guard let data = input.data(using: .utf8) else { return "INVALID" }

        var crc = initial

        for byte in data {
            crc ^= UInt16(byte) << 8
            for _ in 0..<8 {
                if (crc & 0x8000) != 0 { crc = (crc << 1) ^ poly }
                else { crc <<= 1 }
                crc &= 0xFFFF  // Ensure 16-bit
            }
        }

        return String(format: "%04X", crc)
    }
}
