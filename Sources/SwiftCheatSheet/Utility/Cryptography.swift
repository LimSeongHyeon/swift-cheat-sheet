//
//  File.swift
//
//
//  Created by TommyFuture on 11/20/24.
//

import Foundation
import Security

public final class SwiftCryptography
{
    public static func decryptRSA(cipherText: String, privateKey: String, algorithm: SecKeyAlgorithm = .rsaEncryptionPKCS1) -> String?
    {
        var error: Unmanaged<CFError>?
        
        guard let cipherTextData = Data(base64Encoded: cipherText, options: .ignoreUnknownCharacters),
              let privateKeyData = Data(base64Encoded: privateKey, options: .ignoreUnknownCharacters) else { return nil }
        
        let attributes: [String: Any] = [
            String(kSecAttrKeyType): kSecAttrKeyTypeRSA,
            String(kSecAttrKeyClass): kSecAttrKeyClassPrivate,
            String(kSecAttrKeySizeInBits): privateKeyData.count * 8
        ]
        
        guard let privateSecKey = SecKeyCreateWithData(privateKeyData as CFData, attributes as CFDictionary, nil),
              let decryptedData = SecKeyCreateDecryptedData(privateSecKey, algorithm, cipherTextData as CFData, &error) else { return nil }
        
        return String(data: decryptedData as Data, encoding: .utf8)
    }
    
    
    public static func encryptRSA(plainText: String, publicKey: String, algorithm: SecKeyAlgorithm = .rsaEncryptionPKCS1) -> String?
    {
        var error: Unmanaged<CFError>?
        
        guard let plainTextData = plainText.data(using: .utf8),
              let publicKeyData = Data(base64Encoded: publicKey, options: .ignoreUnknownCharacters) else { return nil }
        
        let attributes: [String: Any] = [
            String(kSecAttrKeyType): kSecAttrKeyTypeRSA,
            String(kSecAttrKeyClass): kSecAttrKeyClassPublic,
            String(kSecAttrKeySizeInBits): publicKeyData.count * 8
        ]
        
        guard let publicSecKey = SecKeyCreateWithData(publicKeyData as CFData, attributes as CFDictionary, nil),
              let encryptedData = SecKeyCreateEncryptedData(publicSecKey, algorithm, plainTextData as CFData, &error) else { return nil }
        
        return (encryptedData as Data).base64EncodedString()
    }
}


