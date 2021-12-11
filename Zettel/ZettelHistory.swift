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
//                    .onTapGesture {
//                        zettelData.save()
//                        isPresented = false
//                    }

//                ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                        
                        VStack {
//                            if zettelData.zettel.count == 2 {
//                                Spacer(minLength: geo.size.height/4)
//                            }
//                            if zettelData.zettel.count == 1 {
//                                Spacer(minLength: geo.size.height/2 - 70)
//                            }

                            ForEach(zettelData.zettel.reversed()) { zettel in
 
                                    ZettelView(zettelData: zettelData, isPresented: $isPresented, zettel: zettel, screenSize: geo.size)
                                        .padding(.vertical, 10)
                                
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
//                        .padding(.horizontal, 4)
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
