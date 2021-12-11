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
            
                ScrollView(showsIndicators: false) {
                    ScrollViewReader { proxy in
                        VStack {
                            ForEach(zettelData.zettel.reversed()) { zettel in
                                
                                ZettelView(zettelData: zettelData, isPresented: $isPresented, zettel: zettel, screenSize: geo.size)
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
                        .id(bottomID)
                        .frame(minWidth: geo.size.width, minHeight: geo.size.height, alignment: .center)
                        
                    }
                        
                    }
                
                

            
            
        }
        
    }
}


struct ZettelHistory_Previews: PreviewProvider {
    static var previews: some View {
        ZettelHistory(zettelData: ZettelData(), isPresented: .constant(true))
    }
}
