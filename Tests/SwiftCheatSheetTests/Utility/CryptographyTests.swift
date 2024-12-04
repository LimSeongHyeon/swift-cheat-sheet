//
//  CryptographyTests.swift
//  
//
//  Created by TommyFuture on 11/20/24.
//

import XCTest

final class CryptographyTests: XCTestCase
{
    func testRSAEncryptionAndDecryption() 
    {
        // 테스트용 키 (테스트 환경에서는 교체 필요)
        let privateKey = """
        LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2UUlCQURBTkJna3Foa2lH
        OXcwQkFRRUZBQVNDQktjd2dnU2pBZ0VBQW9JQkFRQ2FZbHU3V3RZWTFjWHEKQ3NK
        cXp1VGFHRU9NUzIrcEszOXVHRCtrM0pOMDdEVTl1TWNET2NXejNQTVBWNDNTYnNm
        WVc4VzQ0VlZIT3M2QgpiZHNGeG5TbUlhamZjOVdZME1VS0YweThLOFFZNDhJN0xr
        TU81NklJeHBEajdmbDJGUnJpYytJaE1NNGx1VEcwCklHNm9WOTdUQW5uUEY4NHJp
        aW1YdG5ML3lmU1dyRjUyZ0VmSk5qd1Y0K2htZEtKNGZOMWlkZHR4cThBOVhoYVoK
        M1lOVzNGWWdPRDBwSTZVLzFGL1dqWjk4R1hRMlhIZytwZ204eXJIeWMrdnVUQlJy
        VlNVdE81ZlkvLyt2anp4Ugp0Zlk5RmNDdEJqdm9RL2ErZEE4WWp4a0srbS9QeEZN
        YUlrQmhGbGViSzl6eFJnczRTL0w5TzVSbmVWQS9FZVAxCjF3OURXa0U1QWdNQkFB
        RUNnZ0VBQXZPTkt5TmhDeXZBQ3ptK0xuNUt6ZmdQaDRXMEttVGlYR09TaU9kdUdy
        cSsKeUZHcFhWQ01ET1NWRVhha0o1RVdXVGFrN0tSREpmZlQ5Wkc0OFk3eUVUQjh5
        dHZMS2k4WWl6azNqblBjUFhrUwpNQ0V4NXoycW9YWVJWRWdyQUJUR2RTeVB0c0I0
        K212a1RUd2UvWEVqbVg5WFBvd25GUHBBMGcySy9JU2EvRXZpCjdiUUMrTmJsaEc1
        TlJQbE4rQ2Rnb29EWENiVXZUNHY0RHh3Qy9iK1BhYjVxNSs0SEhhT2FPYXE2d21t
        MGYwWlQKOHdvRFZWdW9ZUFVaczVja1I3TEdKRGYxTC80RHJvTEw5OUVaNHhxNEk0
        cnFXTEozYTY2c3BpUnFEUk1LZERYUgpmRndJL3NHakNSOVlxRlozNjdaUDRBOHd2
        NDVPdjlrNWc4QlhLRUdVNFFLQmdRRE9SQnlOOU02N0pLTmFYS0kwCnJtZnlPN2w5
        c3A1eGFiMVdTazkxTGxKKy9yRVpWcG5IOENzRXNnK25iZUxuRDJYRzZYd1B1eDY2
        Y25NcVZnYzUKRVQ4SjRheHdUcGVoYjlOS3hpU3p6dy9LV0Y5RzN6NFhhL0ppeFBP
        czZWemVTbmFKdktWbWQ0cGVnckRQMUs3MAppZE1QczVyZGtwK2pBd1c4OG9MNnlM
        VE9ZUUtCZ1FDL204OS83cjBZbmJmWHVEcGt0SWZZcUlRZHJkZStmeTYyCm8rQ3Zy
        ZUQ2elJKdjFyMm5JUzdXT001OWREVGlUNVdkbmMrY3RJTnZmcTNYcGlUMDdRT2ZO
        NTNpcW9YYnVseTAKV2NYOGJpZWdnblpNVm5vSkU4OFNjOVBIS2FSb1g2QStxbFpK
        djd2N1pIYm9TMjdCMlFCK2VoNENBQWQxKzRLUQpackFmc283eDJRS0JnQTlrditq
        TU8xMTJGNGJYNFBjamlQaG9BcWpoMnJkR0YrNUhyM1JrVjUzSXJqamc0S3N1ClBs
        ZWtYa3kxZzdpUXlweTBzaUNPYTNXb3N2V1c1QVViUjJRYVpuOGZMbXZLNTY3dDZM
        Rk9vN1FMTWxrY3NncVgKY01oMFFHZElKemtqdjRMNkJESUllOWdmMHNnLzdDcXQy
        b1dTZHQxUVl2K01hekkxdXhheVFlUWhBb0dBRlhaeApoc1lLUG5Da1FEQ3RzY3di
        RDJUSTc3NGlWWDlQanp2S0ZrT20yTkVSeUo5SVBTbFZZcitZT2F0RHBUbis2MW5i
        CkFKV2p4MkJzUHFTb3JSckRkaGszd1VVU20ydERxUndKTmw1c1orbFZNUFhhMDV0
        NWJYcTE5VEF2NzFVTzBSWXAKZGpkWTZpNzF0czJFU1loeUtyaXBGZFpFLzYwOWtj
        ayszejRVRHZrQ2dZRUFvUC8wSHVZb3FHcDZBQmNmRTdHRQpLcFA4VnlVNGRvazVW
        a0VXRzkvUXkyb2hBMFlLUkhwMnpoZkxsM2VCbnhrNE9WWWV2Rkxrb0RPSVhiUWtE
        QlAzCkg1ZzFtZnZPYzBaK1F1cmJpSnc5YUlaVmNPRk1CNUtmY3dXOHpwSzZYTkUr
        NmpobXc0TERtaE5uVVRPZjQvV3gKckQycXF1dzZkNDA5Y0J5Sk9LN2hITHc9Ci0t
        LS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0K
        """
        
        let publicKey = """
        LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3MEJB
        UUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFtbUpidTFyV0dOWEY2Z3JDYXM3awoyaGhE
        akV0dnFTdC9iaGcvcE55VGRPdzFQYmpIQXpuRnM5enpEMWVOMG03SDJGdkZ1T0ZW
        UnpyT2dXM2JCY1owCnBpR28zM1BWbU5ERkNoZE12Q3ZFR09QQ095NUREdWVpQ01h
        UTQrMzVkaFVhNG5QaUlURE9KYmt4dENCdXFGZmUKMHdKNXp4Zk9LNG9wbDdaeS84
        bjBscXhlZG9CSHlUWThGZVBvWm5TaWVIemRZblhiY2F2QVBWNFdtZDJEVnR4VwpJ
        RGc5S1NPbFA5UmYxbzJmZkJsME5seDRQcVlKdk1xeDhuUHI3a3dVYTFVbExUdVgy
        UC8vcjQ4OFViWDJQUlhBCnJRWTc2RVAydm5RUEdJOFpDdnB2ejhSVEdpSkFZUlpY
        bXl2YzhVWUxPRXZ5L1R1VVozbFFQeEhqOWRjUFExcEIKT1FJREFRQUIKLS0tLS1F
        TkQgUFVCTElDIEtFWS0tLS0tCg==
        """
        
        let plainText = "Hello, RSA Encryption!"
        
        // RSA 암호화
        guard let cipherText = SwiftCryptography.encryptRSA(plainText: plainText, publicKey: publicKey) else {
            XCTFail("Encryption failed")
            return
        }
        
        print("Encrypted: \(cipherText)")
        
        // RSA 복호화
        guard let decryptedText = decryptRSA(cipherText: cipherText, privateKey: privateKey) else {
            XCTFail("Decryption failed")
            return
        }
        
        print("Decrypted: \(decryptedText)")
        XCTAssertEqual(decryptedText, plainText, "Decrypted text should match the original plain text")
    }
    
    func testDecryptWithInvalidPrivateKey() 
    {
        let cipherText = "CipherTextSample"
        let invalidPrivateKey = "InvalidPrivateKeyBase64"
        
        let result = decryptRSA(cipherText: cipherText, privateKey: invalidPrivateKey)
        XCTAssertNil(result, "Decryption should fail with an invalid private key")
    }
    
    func testEncryptWithInvalidPublicKey() 
    {
        let plainText = "Sample Text"
        let invalidPublicKey = "InvalidPublicKeyBase64"
        
        let result = encryptRSA(plainText: plainText, publicKey: invalidPublicKey)
        XCTAssertNil(result, "Encryption should fail with an invalid public key")
    }

}
