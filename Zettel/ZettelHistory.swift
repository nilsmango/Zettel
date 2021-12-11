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
    

    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                        
                        VStack {
                            ForEach(zettelData.zettel.reversed()) { zettel in
 
                                    ZettelView(zettelData: zettelData, isPresented: $isPresented, zettel: zettel, screenSize: geo.size)
                                        .padding(.vertical, 10)
                                
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    }
                
//                    .onAppear {
////                        if zettelData.zettel.count > 3 {
//                        proxy.scrollTo(bottomID)
////                        }
//                        }
                    
//                }
            }
            
        }
    }
}


struct ZettelHistory_Previews: PreviewProvider {
    static var previews: some View {
        ZettelHistory(zettelData: ZettelData(), isPresented: .constant(true))
    }
}
