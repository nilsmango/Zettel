//
//  ZettelData.swift
//  Zettel
//
//  Created by Simon Lang on 09.11.21.
//

import Foundation
import WidgetKit

class ZettelData: ObservableObject {
    
    private static var documentsFolder: URL {
        let appIdentifier = "group.qrcoder.codes"
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appIdentifier)!
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("zettel.data")
    }
    
    @Published var zettel: [Zettel] = [Zettel(text: "This is your note.", showSize: .small, fontSize: .compact)]
    
    @Published var deletedZettel: [Zettel] = []
    
    func restoreLastDeletedZettel() {
        let restoredZettel = deletedZettel.last ?? Zettel(text: "We couldn't find your last note.", showSize: .small, fontSize: .compact)
        deletedZettel.removeLast()
        zettel.append(restoredZettel)
    }
    
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                return
            }
            guard let jsonZettel = try? JSONDecoder().decode([Zettel].self, from: data) else {
                fatalError("Couldn't decode saved codes data")
            }
            DispatchQueue.main.async {
                self?.zettel = jsonZettel
                
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let zettel = self?.zettel else { fatalError("Self out of scope!") }
            guard let data = try? JSONEncoder().encode(zettel) else { fatalError("Error encoding data") }
            
            do {
                let outFile = Self.fileURL
                try data.write(to: outFile)
                WidgetCenter.shared.reloadAllTimelines()
                
            } catch {
                fatalError("Couldn't write to file")
            }
        }
    }
}
