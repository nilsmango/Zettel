//
//  ZettelHistory.swift
//  Zettel
//
//  Created by Simon Lang on 09.12.21.
//

import SwiftUI



struct ZettelHistory: View {
    
    @ObservedObject var zettelData: ZettelData
    
    @Binding var isPresented: Bool
    
    @Namespace var bottomID
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented = false
                    }
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        
                        VStack {
                            ForEach(zettelData.zettel.reversed()) { zettel in
                                ZStack {
                                    ZettelView(zettelData: zettelData, isPresented: $isPresented, zettel: zettel, screenSize: geo.size)
                                        .padding(.vertical, 10)
                                }
                            }
                        }
                        .id(bottomID)
                        .padding(.horizontal, 4)
                    }
                    .onAppear { proxy.scrollTo(bottomID) }
                    
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
