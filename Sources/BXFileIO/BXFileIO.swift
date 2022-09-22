import Foundation

public struct BXFileIO {
  var manager = FileManager.default
  
  /// Create a directory named `name` if not exist.
  func createDirectory(name: String) throws {
    let rootUrl = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let dirUrl = rootUrl.appendingPathComponent(name)
    
    if !manager.fileExists(atPath: dirUrl.relativePath) {
      try manager.createDirectory(at: dirUrl, withIntermediateDirectories: false, attributes: nil)
    }
  }
  
  func clearDirectory(name: String) {
    do {
      let rootUrl = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      let dirUrl = rootUrl.appendingPathComponent(name)
      
      let fileUrls = try manager.contentsOfDirectory(at: dirUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
      
      for fileUrl in fileUrls {
        try manager.removeItem(at: fileUrl)
      }
    }
    catch {
      print("Cannot clear \(name) directory: \(error.localizedDescription)")
    }
  }
  
  func checkDirectoryExist(name: String) -> Bool {
    do {
      let rootUrl = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      let dirUrl = rootUrl.appendingPathComponent(name)
      
      let isDirExist = manager.fileExists(atPath: dirUrl.relativePath)
      
      return isDirExist
    }
    catch {
      return false
    }
  }
  
  func readFile(_ fileName: String, from dirName: String) throws -> Data {
    do {
      let rootUrl = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      let fileUrl = rootUrl.appendingPathComponent(dirName).appendingPathComponent(fileName)
      
      return try Data(contentsOf: fileUrl)
    }
    catch {
      print("Cannot read \(fileName) from \(dirName).")
      throw error
    }
  }
  
  func writeFile(_ fileName: String, data: Data, to dirName: String) {
    do {
      let rootUrl = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      let fileUrl = rootUrl.appendingPathComponent(dirName).appendingPathComponent(fileName)
      
      try data.write(to: fileUrl)
    }
    catch {
      print("Cannot cache file: \(fileName)")
    }
  }
}
