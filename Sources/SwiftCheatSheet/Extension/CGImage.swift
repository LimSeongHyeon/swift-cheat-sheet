//
//  File.swift
//  
//
//  Created by TommyFuture on 7/31/24.
//

import Foundation
import SwiftUI

public extension CGImage
{
    /// `CGImage`를 주어진 크기로 리사이즈합니다.
    /// - Parameter size: 리사이즈할 목표 크기 (`CGSize`).
    /// - Returns: 리사이즈된 `CGImage` 객체를 반환하며, 실패 시 `nil`을 반환합니다.
    ///
    /// 이 함수는 `CGContext`를 사용하여 이미지를 새로운 크기로 그린 후 리사이즈된 이미지를 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// if let resizedImage = originalImage.resize(size: CGSize(width: 100, height: 100)) { /* Image resized successfully. */ }
    /// else { /* Failed to resize image. */ }
    /// ```
    func resize(size:CGSize) -> CGImage?
    {
        let width: Int = Int(size.width)
        let height: Int = Int(size.height)
        
        let bytesPerPixel = self.bitsPerPixel / self.bitsPerComponent
        let destBytesPerRow = width * bytesPerPixel
        
        
        guard let colorSpace = self.colorSpace else { return nil }
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: self.bitsPerComponent, bytesPerRow: destBytesPerRow, space: colorSpace, bitmapInfo: self.alphaInfo.rawValue) else { return nil }
        
        context.interpolationQuality = .high
        context.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        return context.makeImage()
    }
    
    
    /// `CGImage`를 지정된 각도로 회전시킵니다.
    /// - Parameter degree: 회전할 각도(도 단위, 시계 방향).
    /// - Returns: 회전된 `CGImage` 객체를 반환하며, 실패 시 `nil`을 반환합니다.
    ///
    /// 이 함수는 주어진 각도만큼 이미지를 회전시키고, 새로운 `CGContext`에 회전된 이미지를 그려 반환합니다.
    ///
    /// - Usage:
    /// ```swift
    /// if let rotatedImage = originalImage.rotate(degree: 90) { /* Image rotated successfully. */ } 
    /// else { /* Failed to rotate image. */ }
    /// ```
    ///
    /// - Note: 각도는 시계 방향으로 회전되며, 입력 각도는 도 단위입니다.
    func rotate(degree: CGFloat) -> CGImage?
    {
        let imageWidth = self.width
        let imageHeight = self.height
        
        let radians = degree * .pi / 180.0
        let rotatedSize = CGSize(width: CGFloat(imageWidth), height: CGFloat(imageHeight)).applying(CGAffineTransform(rotationAngle: radians))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bitsPerComponent = 8
        let bytesPerRow = bytesPerPixel * Int(rotatedSize.width)
        
        guard let context = CGContext(data: nil,
                                      width: Int(rotatedSize.width),
                                      height: Int(rotatedSize.height),
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil
        }
        
        let transform = CGAffineTransform(translationX: rotatedSize.width / 2, y: rotatedSize.height / 2)
            .rotated(by: radians)
            .translatedBy(x: -CGFloat(imageWidth) / 2, y: -CGFloat(imageHeight) / 2)
        
        context.concatenate(transform)
        
        context.draw(self, in: CGRect(x: 0, y: 0, width: CGFloat(imageWidth), height: CGFloat(imageHeight)))
        
        return context.makeImage()
    }
}
