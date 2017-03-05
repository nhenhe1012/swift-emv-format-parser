//
//  SwiftEmvType.swift
//  swift-emv-format-parser
//
//  Created by Tien Nguyen on 15/6/25.
//

enum EmvParseStatus {
    case none
    case wrongFormat
    case success
}

enum EmvRootObjectType {
    case PayloadFormatIndicator
    case PointOfInitiationMethod
    case MerchantAccountInformation
    case MerchantCategoryCode
    case TransactionCurrency
    case TransactionAmount
    case TipOrConvenienceIndicator
    case ValueOfConvenienceFeeFixed
    case ValueOfConvenienceFeePercentage
    case CountryCode
    case MerchantName
    case MerchantCity
    case PostalCode
    case AdditionalData
    case MerchantLanguage
    case RFU
    case UnreservedsTemplate
    case CRC

    init(_ rawValue: String) {
        switch rawValue {
        case "00":
            self = .PayloadFormatIndicator
        case "01":
            self = .PointOfInitiationMethod
        case "02", "03", "04", "05", "06", "07", "08", "09", "10",
            "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
            "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
            "31", "32", "33", "34", "35", "36", "37", "38", "39", "40",
            "41", "42", "43", "44", "45", "46", "47", "48", "49", "50",
            "51":
            self = .MerchantAccountInformation
        case "52":
            self = .MerchantCategoryCode
        case "53":
            self = .TransactionCurrency
        case "54":
            self = .TransactionAmount
        case "55":
            self = .TipOrConvenienceIndicator
        case "56":
            self = .ValueOfConvenienceFeeFixed
        case "57":
            self = .ValueOfConvenienceFeePercentage
        case "58":
            self = .CountryCode
        case "59":
            self = .MerchantName
        case "60":
            self = .MerchantCity
        case "61":
            self = .PostalCode
        case "62":
            self = .AdditionalData
        case "63":
            self = .CRC
        case "64":
            self = .MerchantLanguage
        case "65", "66", "67", "68", "69", "70",
            "71", "72", "73", "74", "75", "76", "77", "78", "79":
            self = .RFU
        default:
            self = .UnreservedsTemplate
        }
    }
}

enum EmvRootAdditionalDataFieldTemplate {
    case billNumber                     // 01
    case mobileNumber                   // 02
    case storeLabel                     // 03
    case loyaltyNumber                  // 04
    case referenceLabel                 // 05
    case customerLabel                  // 06
    case terminalLabel                  // 07
    case purposeOfTransaction           // 08
    case additionalCustomerDataRequest  // 09
    case RFU                            // 10 - 49
    case paymentSystemSpecificTemplate  // 50 - 99
}

protocol EmvObjectProtocol {
    var id: String { get set }
    var length: Int { get set }
    var value: String { get set }
    var array: [EmvObject] { get set }
}

public struct EmvObject: EmvObjectProtocol {
    var id: String
    var length: Int
    var value: String
    var array: [EmvObject]
}

public struct EmvData {
    var array: [EmvObject]
    
    func checksum() -> String? {
        return array.first(where: { $0.id == "63" })?.value
    }
}
