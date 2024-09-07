//
//  ZettelView.swift
//  Zettel
//
//  Created by Simon Lang on 09.12.21.
//

import SwiftUI

struct ZettelView: View {

    @ObservedObject var zettelData: ZettelData
    
    @Binding var isPresented: Bool
            
    var zettel: Zettel
    
    @Binding var wasChosen: Bool
    
    var screenSize: CGSize
    
    private var textSize: CGFloat {
        if zettel.fontSize == .large {
            return CGFloat(20)
        }
        if zettel.fontSize == .compact {
            return CGFloat(12)
        }
        else {
            return CGFloat(16)
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 21.67, style: .continuous)
                    .fill(Color("WidgetColor"))
                
                VStack {
                    Text(zettel.text)
                        .font(.system(size: textSize))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 11, leading: 12, bottom: 13, trailing: 12))
                    Spacer()
                }
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation() {
                                guard let index = zettelData.zettel.firstIndex(where: { $0.id == zettel.id }) else {
                                    fatalError("couldn't find the index for data")
                                }
                                if zettelData.zettel.count > 1 {
                                    zettelData.deletedZettel.append(zettelData.zettel[index])
                                    zettelData.zettel.remove(at: index)
                                } else {
                                    zettelData.deletedZettel.append(zettelData.zettel[0])
                                    let showSize = zettelData.zettel[0].showSize
                                    let fontSize = zettelData.zettel[0].fontSize
                                    zettelData.zettel.removeAll()
                                    zettelData.zettel.append(Zettel(text: "", showSize: showSize, fontSize: fontSize))
                                    isPresented = false
                                }
                            }
                            
                        })
                        {
                            Label("Delete Zettel", systemImage: "xmark.circle.fill")}
                        .opacity(wasChosen ? 0.0 : 1.0)
                        .labelStyle(.iconOnly)
                        .offset(x: 5, y: -5)
                        
                    }

                    Spacer()
                }
            }
            .frame(width: geoMagic(width: screenSize.width, height: screenSize.height, showingSheet: false, widgetSize: zettel.showSize).width, height: geoMagic(width: screenSize.width, height: screenSize.height, showingSheet: false, widgetSize: zettel.showSize).height + 1)
            .onTapGesture {
                guard let index = zettelData.zettel.firstIndex(where: { $0.id == zettel.id }) else {
                    fatalError("couldn't find the index for data")
                }
              
                wasChosen = true
                
                zettelData.zettel.move(from: index, to: 0)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isPresented = false
                }
            }
        }
    }
}


struct ZettelView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            ZettelView(zettelData: ZettelData(), isPresented: .constant(false), zettel: Zettel.sampleData[1], wasChosen: .constant(false), screenSize: CGSize(width: 470, height: 700))
        }
    }
}
