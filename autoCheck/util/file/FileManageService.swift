//
//  saveFIle.swift
//  autoCheck
//
//  Created by 방성환 on 9/29/23.
//

import Foundation

class FileManageService {
    func saveTextToFile(_ param: String, fileName: String) {
        do {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            
            try param.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("파일 저장 오류: \(error)")
        }
    }
        
    func readTextFromFile(fileName: String) -> String {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            let savedText = try String(contentsOf: fileURL, encoding: .utf8)
            return savedText
        } catch {
            print("파일 읽기 오류: \(error)")
            return ""
        }
    }
}
