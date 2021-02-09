//
//  TestForWebPage.swift
//  PBLAuthBridge
//
//  Created by Pete Misik on 2/5/21.
//

import SwiftUI

struct TestForWebPage: View {
    var body: some View {
        ZStack {
            VStack {
                Text(":)")
                Text(getHTMLData())
            }
        }
    }

    func getNumberOfDocuments() -> Int {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        do {
            let files = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            
            return files.count
            
        } catch {
            NSLog("Return 0")
        }
        return 0
    }

    func getDocumentsArray() -> [URL] {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        do {
            let files = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            
            return files
            
        } catch {
            NSLog("No documents found")
        }
        
        return []
    }

    func getWebsite(url: URL) {
        
        let downloadTask = URLSession.shared.downloadTask(with: url) {
            urlOrNil, responseOrNil, errorOrNil in
            guard let fileURL = urlOrNil else { return }
            do {
                let documentsURL = try
                    FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
                let savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
                try FileManager.default.moveItem(at: fileURL, to: savedURL)
            } catch {
                NSLog("File error: \(error)")
            }
        }
        downloadTask.resume()
    }

    func getHTMLData() -> String{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let files = getNumberOfDocuments()
        let fileList = getDocumentsArray()
        
        NSLog("***************************************")
        NSLog("\(documentsDirectory)")
        NSLog("***************************************")
        if files > 0 {
            let fileURL = documentsDirectory.appendingPathComponent(fileList[0].lastPathComponent)
            
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                print("\(fileURL)")
                return text2
            } catch {
                NSLog("File read error")
            }
        } else {
            NSLog("Documents Directory is empty")
            NSLog("Attempting to download")
            getWebsite(url: URL(string: "https://jira.il2.dso.mil/secure/RapidBoard.jspa?rapidView=301")!)
            
            let files2 = getNumberOfDocuments()
            if files2 > 0 {
                NSLog("Trying to pull new data")
                let fileList2 = getDocumentsArray()
                let fileURL = documentsDirectory.appendingPathComponent(fileList2[0].lastPathComponent)
                
                do {
                    let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                    print("\(fileURL)")
                    return text2
                } catch {
                    NSLog("File read error")
                }
            }
            
        }
        return ""
    }
}

struct TestForWebPage_Previews: PreviewProvider {
    static var previews: some View {
        TestForWebPage()
    }
}
