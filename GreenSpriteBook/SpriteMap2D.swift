//
//  SpriteMap2D.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 20/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public struct SpriteMap2DHeader {
    fileprivate let magicNumber = 0xFF4223
    var width: Int
    var height: Int
}

open class SpriteMap2D<Object>: NSObject {
    
    public var header: SpriteMap2DHeader
    public var array: [[Object]]
    
    public init(size: CGSize, `default`: Object) {
        self.header = SpriteMap2DHeader.init(width: Int(size.width), height: Int(size.height))
        self.array = Array(repeating: Array(repeating: `default`, count: self.header.width), count: self.header.height)
        super.init()
    }
    
    fileprivate init(header: SpriteMap2DHeader, array: [[Object]]) {
        self.header = header
        self.array = array
        super.init()
    }
    
    enum SpriteMap2DProcessError: Error {
        case badPath
        case badFile
        case cannotTruncate
        case cannotRead
    }
    
    public func write(to path: String) throws {
        
        if !FileManager.default.fileExists(atPath: path) {
            FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        }
        else {
            guard let updateFile = FileHandle.init(forUpdatingAtPath: path) else {
                throw SpriteMap2DProcessError.cannotTruncate
            }
            
            updateFile.truncateFile(atOffset: 0)
            updateFile.closeFile()
        }
        guard let file = FileHandle.init(forWritingAtPath: path) else {
            throw SpriteMap2DProcessError.cannotTruncate
        }
        let rowSize = MemoryLayout<Object>.size * self.header.width
        
        file.write(.init(bytesNoCopy: &self.header, count: MemoryLayout<SpriteMap2DHeader>.size, deallocator: .none))
        for var row in self.array {
            file.write(.init(bytesNoCopy: &row, count: rowSize, deallocator: .none))
        }
        file.closeFile()
    }
    
    public class func read(from path: String, `default`: Object) throws -> SpriteMap2D {
        
        guard let file = FileHandle.init(forReadingAtPath: path) else {
            throw SpriteMap2DProcessError.cannotRead
        }
        var header = SpriteMap2DHeader.init(width: 0, height: 0)
        let headerData = file.readData(ofLength: MemoryLayout<SpriteMap2DHeader>.size)
        let rowSize: Int
        var array: [[Object]] = [[]]
        
        if headerData.count != MemoryLayout<SpriteMap2DHeader>.size {
            throw SpriteMap2DProcessError.badFile
        }
        headerData.withUnsafeBytes { ptr in
            header = (ptr as UnsafePointer<SpriteMap2DHeader>).pointee
        }
        rowSize = MemoryLayout<Object>.size * header.width
        for _ in 1...header.height {
            let rowData = file.readData(ofLength: rowSize)
            var rowArray = Array(repeating: `default`, count: header.width)
            
            if rowData.count != rowSize {
                throw SpriteMap2DProcessError.badFile
            }
            _ = rowData.withUnsafeBytes { ptr in
                memmove(&rowArray, ptr, rowSize)
            }
            array.append(rowArray)
        }
        file.closeFile()
        return SpriteMap2D.init(header: header, array: array)
    }
    
}
