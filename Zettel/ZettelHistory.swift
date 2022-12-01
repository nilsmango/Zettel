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
    
    @State private var wasChosen = false
    
    @Namespace var bottomID
    
    var screenSize: CGSize
    
    var body: some View {
            
            ScrollView(showsIndicators: false) {
                ScrollViewReader { proxy in
                    VStack {
                        if wasChosen {
                            
                        } else {
                            ForEach(zettelData.zettel.reversed()) { zettel in
                                ZettelView(zettelData: zettelData, isPresented: $isPresented, zettel: zettel, wasChosen: $wasChosen.animation(), screenSize: screenSize)
                                    .padding(.vertical, 10)

                            }
                            .onAppear() {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    withAnimation {
                                        proxy.scrollTo(bottomID)
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                    .id(bottomID)
                    .frame(minWidth: screenSize.width, minHeight: screenSize.height, alignment: .center)
                }
            }
        
        
    }
}


struct ZettelHistory_Previews: PreviewProvider {
    static var previews: some View {
        ZettelHistory(zettelData: ZettelData(), isPresented: .constant(true), screenSize: CGSize(width: 470, height: 700))
    }
}
