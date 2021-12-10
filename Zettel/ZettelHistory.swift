//
//  ZettelHistory.swift
//  Zettel
//
//  Created by Simon Lang on 09.12.21.
//

import SwiftUI

extension Array
{
    mutating func move(from oldIndex: Index, to newIndex: Index) {
        // Don't work for free and use swap when indices are next to each other - this
        // won't rebuild array and will be super efficient.
        if oldIndex == newIndex { return }
        if abs(newIndex - oldIndex) == 1 { return self.swapAt(oldIndex, newIndex) }
        self.insert(self.remove(at: oldIndex), at: newIndex)
    }
}

struct ZettelHistory: View {
    
    @ObservedObject var zettelData: ZettelData

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(zettelData.zettel) { zettel in
                            ZStack {
                                ZettelView(zettelData: zettelData, zettel: zettel, screenSize: geo.size)
                                    .padding(.vertical, 10)
                                    .onTapGesture {
                                        guard let index = zettelData.zettel.firstIndex(where: { $0.id == zettel.id }) else {
                                            fatalError("couldn't find the index for data")
                                        }
                                        zettelData.zettel.remove(at: index)
                                    }
                            }

                        }
                        
                    }
                }
                
            }
        }
        
        
    }
}

//
//struct ZettelHistory_Previews: PreviewProvider {
//    static var previews: some View {
//        ZettelHistory(zettelData: ZettelData(), zettelZeug: Zettel.sampleData)
//    }
//}
