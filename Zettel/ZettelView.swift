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
    
    private func geoMagic(width: CGFloat, height: CGFloat) -> (width: CGFloat, height: CGFloat) {

            if width > 427 {
                if zettel.showSize == .large {
                    return (364, 382)
                } else if zettel.showSize == .medium {
                    return (364, 170)
                } else {
                    return (170, 170)
                }
            } else if width == 414 && height > 736 {
                if zettel.showSize == .large {
                    return (360, 379)
                } else if zettel.showSize == .medium {
                    return (360, 169)
                } else {
                    return (169, 169)
                }
            } else if width == 414 && height < 736 {
                if zettel.showSize == .large {
                    return (348, 357)
                } else if zettel.showSize == .medium {
                    return (348, 157)
                } else {
                    return (159, 159)
                }
            } else if width == 390 {
                if zettel.showSize == .large {
                    return (338, 354)
                } else if zettel.showSize == .medium {
                    return (338, 157)
                } else {
                    return (158, 158)
                }
            } else if width == 375 && height > 667 || width == 360 {
                if zettel.showSize == .large {
                    return (329, 345)
                } else if zettel.showSize == .medium {
                    return (329, 155)
                } else {
                    return (155, 155)
                }
            } else if width == 375 && height < 667 {
                if zettel.showSize == .large {
                    return (321, 324)
                } else if zettel.showSize == .medium {
                    return (321, 148)
                } else {
                    return (148, 148)
                }
            } else if width == 320 {
               if zettel.showSize == .large {
                   return (292, 311)
               } else if zettel.showSize == .medium {
                   return (292, 141)
               } else {
                   return (141, 141)
               }
           } else if width == 768 {
               if zettel.showSize == .large {
                   return (260, 260)
               } else if zettel.showSize == .medium {
                   return (260, 120)
               } else {
                   return (120, 120)
               }
           } else if width == 810 {
               if zettel.showSize == .large {
                   return (272, 272)
               } else if zettel.showSize == .medium {
                   return (272, 124)
               } else {
                   return (124, 124)
               }
           } else if width == 834 && height < 1110 {
               if zettel.showSize == .large {
                   return (288, 288)
               } else if zettel.showSize == .medium {
                   return (288, 132)
               } else {
                   return (132, 132)
               }
           } else if width == 820 || width == 834 && height > 1110 {
               if zettel.showSize == .large {
                   return (300, 300)
               } else if zettel.showSize == .medium {
                   return (300, 136)
               } else {
                   return (136, 136)
               }
           } else if width == 1024 {
               if zettel.showSize == .large {
                   return (356, 356)
               } else if zettel.showSize == .medium {
                   return (356, 160)
               } else {
                   return (160, 160)
               }
           }
            
            return (width/3, height/5)
        }

    
    
    var body: some View {
        VStack {
            ZStack {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill(Color("WidgetColor"))
                        
                        VStack {
                            Text(zettel.text)
                                            .font(.system(size: textSize))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(EdgeInsets(top: 19, leading: 17, bottom: 13, trailing: 12))
                            Spacer()
                        }
                        
                        VStack {
                            HStack {
                                Spacer()
                               
                                
                                    Button(action: {
                                        withAnimation {
                                        guard let index = zettelData.zettel.firstIndex(where: { $0.id == zettel.id }) else {
                                            fatalError("couldn't find the index for data")
                                        }
                                            if zettelData.zettel.count > 1 {
                                            zettelData.zettel.remove(at: index)
                                            } else {
                                                zettelData.zettel[0].text = ""
                                                isPresented = false
                                            }
                                        }
                                   })
                                    {
                                        Label("Delete Zettel", systemImage: "xmark.circle.fill")}

                                    .labelStyle(.iconOnly)
                                    .offset(x: 5, y: -5)
                                    
                                }
                                    
                            
                            
                            Spacer()
                        }
                    }
                    .frame(width: geoMagic(width: screenSize.width, height: screenSize.height).width, height: geoMagic(width: screenSize.width, height: screenSize.height).height + 1)
                    .onTapGesture {
                        guard let index = zettelData.zettel.firstIndex(where: { $0.id == zettel.id }) else {
                            fatalError("couldn't find the index for data")
                        }
                        zettelData.zettel.move(from: index, to: 0)
                        
                            isPresented = false
                    }
        }
        
        
        
        
        
        
    }
}


struct ZettelView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            ZettelView(zettelData: ZettelData(), isPresented: .constant(false), zettel: Zettel.sampleData[1], screenSize: CGSize(width: 470, height: 700))
        }
    }
}
