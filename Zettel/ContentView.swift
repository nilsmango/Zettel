//
//  ContentView.swift
//  Zettel
//
//  Created by Simon Lang on 07.11.21.
//

import SwiftUI



struct ContentView: View {
    
    @ObservedObject var zettelData: ZettelData
    
    @FocusState private var editorIsFocused: FocusField?
    
    enum FocusField: Hashable {
        case field
      }
    
    @State private var showingSheet = false
    
    @Binding var isPresented: Bool
    

    
    private var textSize: CGFloat {
        if zettelData.zettel.first?.fontSize == .large {
            return CGFloat(20)
        }
        if zettelData.zettel.first?.fontSize == .compact {
            return CGFloat(12)
        }
        else {
            return CGFloat(16)
        }
    }
    
    private var frameWidth: CGFloat {
        if zettelData.zettel.first?.showSize == .large {
            return CGFloat(348)
        }
        if zettelData.zettel.first?.showSize == .medium {
            return CGFloat(348)
        }
        else {
            return CGFloat(165)
        }
    }
    
    private var frameHeight: CGFloat {
        if zettelData.zettel.first?.showSize == .large {
            return CGFloat(357)
        }
        else {
            return CGFloat(165)
        }
    }
    
    private func geoMagic(width: CGFloat, height: CGFloat) -> (width: CGFloat, height: CGFloat) {
        if showingSheet == true {
            if width > 427 {
                    return (364, 382)
                
            } else if width == 414 && height > 736 {

                    return (360, 379)
                
            } else if width == 414 && height < 736 {

                    return (348, 357)
                
            } else if width == 390 {

                    return (338, 354)
                
            } else if width == 375 && height > 667 || width == 360 {

                    return (329, 345)
                
            } else if width == 375 && height < 667 {

                    return (321, 324)
                
            } else if width == 320 {

                   return (292, 311)
               
           } else if width == 768 {

                   return (260, 260)
               
           } else if width == 810 {

                   return (272, 272)
               
           } else if width == 834 && height < 1110 {

                   return (288, 288)
               
           } else if width == 820 || width == 834 && height > 1110 {

                   return (300, 300)
               
           } else if width == 1024 {

                   return (356, 356)
               }

        } else if showingSheet == false {
            if width > 427 {
                if zettelData.zettel.first?.showSize == .large {
                    return (364, 382)
                } else if zettelData.zettel.first?.showSize == .medium {
                    return (364, 170)
                } else {
                    return (170, 170)
                }
            } else if width == 414 && height > 736 {
                if zettelData.zettel.first?.showSize == .large {
                    return (360, 379)
                } else if zettelData.zettel.first?.showSize == .medium {
                    return (360, 169)
                } else {
                    return (169, 169)
                }
            } else if width == 414 && height < 736 {
                if zettelData.zettel.first?.showSize == .large {
                    return (348, 357)
                } else if zettelData.zettel.first?.showSize == .medium {
                    return (348, 157)
                } else {
                    return (159, 159)
                }
            } else if width == 390 {
                if zettelData.zettel.first?.showSize == .large {
                    return (338, 354)
                } else if zettelData.zettel.first?.showSize == .medium {
                    return (338, 157)
                } else {
                    return (158, 158)
                }
            } else if width == 375 && height > 667 || width == 360 {
                if zettelData.zettel.first?.showSize == .large {
                    return (329, 345)
                } else if zettelData.zettel.first?.showSize == .medium {
                    return (329, 155)
                } else {
                    return (155, 155)
                }
            } else if width == 375 && height < 667 {
                if zettelData.zettel.first?.showSize == .large {
                    return (321, 324)
                } else if zettelData.zettel.first?.showSize == .medium {
                    return (321, 148)
                } else {
                    return (148, 148)
                }
            } else if width == 320 {
               if zettelData.zettel.first?.showSize == .large {
                   return (292, 311)
               } else if zettelData.zettel.first?.showSize == .medium {
                   return (292, 141)
               } else {
                   return (141, 141)
               }
           } else if width == 768 {
               if zettelData.zettel.first?.showSize == .large {
                   return (260, 260)
               } else if zettelData.zettel.first?.showSize == .medium {
                   return (260, 120)
               } else {
                   return (120, 120)
               }
           } else if width == 810 {
               if zettelData.zettel.first?.showSize == .large {
                   return (272, 272)
               } else if zettelData.zettel.first?.showSize == .medium {
                   return (272, 124)
               } else {
                   return (124, 124)
               }
           } else if width == 834 && height < 1110 {
               if zettelData.zettel.first?.showSize == .large {
                   return (288, 288)
               } else if zettelData.zettel.first?.showSize == .medium {
                   return (288, 132)
               } else {
                   return (132, 132)
               }
           } else if width == 820 || width == 834 && height > 1110 {
               if zettelData.zettel.first?.showSize == .large {
                   return (300, 300)
               } else if zettelData.zettel.first?.showSize == .medium {
                   return (300, 136)
               } else {
                   return (136, 136)
               }
           } else if width == 1024 {
               if zettelData.zettel.first?.showSize == .large {
                   return (356, 356)
               } else if zettelData.zettel.first?.showSize == .medium {
                   return (356, 160)
               } else {
                   return (160, 160)
               }
           }
            
            return (width/3, height/5)
        }
        
        return (width/3, height/5)
    }
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                    .opacity(0.0)
                    .onTapGesture {
                        editorIsFocused = nil
                    }
                
                VStack {

                    
                    Spacer()

                    ZStack {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .fill(Color("WidgetColor"))
                        
                        if #available(iOS 16.0, *) {
                            TextEditor(text: $zettelData.zettel[0].text)
                                .scrollContentBackground(.hidden)
                                .focused($editorIsFocused, equals: .field)
                                .font(.system(size: textSize))
                                .padding(EdgeInsets(top: 11, leading: 12, bottom: 13, trailing: 12))
                                .onAppear() {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                                        editorIsFocused = .field
                                    }
                                }
                        } else {
                            TextEditor(text: $zettelData.zettel[0].text)
                                .focused($editorIsFocused, equals: .field)
                                .font(.system(size: textSize))
                                .padding(EdgeInsets(top: 11, leading: 12, bottom: 13, trailing: 12))
                                .onAppear() {
                                    UITextView.appearance().backgroundColor = UIColor(Color("WidgetColor"))
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                                        editorIsFocused = .field
                                    }
                                }
                        }
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                if zettelData.zettel[0].text.count > 0 {
                                    Button(action: { zettelData.zettel[0].text = ""
                                   }) {
                                        Label("Erase Text", systemImage: "xmark.circle.fill")}
                                    .labelStyle(.iconOnly)
                                    .padding(5)
                                }
                                
                            }
                            
                        }

                        if showingSheet {
                            ZStack {
                                RoundedRectangle(cornerRadius: 13, style: .continuous)
                                    .fill(Color("WidgetColor"))
                                VStack(alignment: .leading) {
                                    
//                                    Spacer()
                                    Text("About")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    HStack {
                                        Text("Find us: [project7III](https://project7iii.com)")
                                    }
                                    HStack {
                                        Text("Write to us: [zettel@project7iii.com](mailto:zettel@project7iii.com)")
                                    }
                                    Text("")
                                    Group {
                                        Text("How to add a Zettel widget")
                                            .fontWeight(.bold)
                                        Text("1. Go to the Home Screen")
                                        Text("2. Long press to enter wiggle mode")
                                        Text("3. Tap the +")
                                        Text("4. Search for Zettel")
                                        Text("5. Add the Zettel widget of your choice")
                                        Text("\nNote: The widget will always show the Zettel you worked on last.")
                                            .foregroundColor(Color(.gray))
                                        Text("\nVersion Log:\n1.0 made with ❤️ by [Nils Mango](https://nilsmango.ch) in Switzerland, 2021-2022.")
                                    }
                                    
                                    Spacer()
                                    
                                }
                                .font(.system(size: 12))
                                .padding(EdgeInsets(top: 13, leading: 13, bottom: 13, trailing: 13))
                                
                                VStack {
                                    
                                    HStack {
                                        Spacer()
                                        Button(action: { showingSheet = false }) {
                                            Label("Dismiss", systemImage: "xmark.circle.fill")}
                                                .labelStyle(.iconOnly)
//                                                .padding(5)
                                                .offset(x: 5, y: -5)
                                    }
                                    Spacer()
                                }
                            }
                        }

                    }
                    .frame(width: geoMagic(width: geo.size.width, height: geo.size.height).width, height: geoMagic(width: geo.size.width, height: geo.size.height).height + 1)
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                
                VStack {
                    HStack {
                        Spacer()
                        if (editorIsFocused != nil) {
                            Button("Done") {
                                editorIsFocused = nil
                            }
                            .font(.headline)
                            .padding(.leading, 5)
                        }
                        Menu {
                            Picker("Widget Size Shown", selection: $zettelData.zettel[0].showSize) {
                                ForEach(Zettel.ShowSize.allCases) { type in
                                    Text(type.rawValue.capitalized + " Widget")
                                        .tag(type)
                                }
                            }
                            Picker("Font Size", selection: $zettelData.zettel[0].fontSize) {
                                ForEach(Zettel.FontSize.allCases) { type in
                                    Text(type.rawValue.capitalized + " Font")
                                        .tag(type)
                                }
                            }
                            Button(action: { showingSheet = true } ) {
                                Label("About", systemImage: "info.circle")
                            }
                        } label: {
                            Label("Options", systemImage: "ellipsis.circle")
                                .labelStyle(.iconOnly)
                                .font(.title2)
                                
                        }
                        
                    }
                    .padding(.trailing)
                .padding(.top)

                
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        if showingSheet == true {
                            Button(action: { showingSheet = false }) {
                                Label("Back to current Zettel", systemImage: "square.fill")
                            }
                        } else {
                            Button(action: {
                                zettelData.zettel.insert(Zettel(text: "", showSize: zettelData.zettel[0].showSize, fontSize: zettelData.zettel[0].fontSize), at: 0)
                                // insert a new empty zettel at 0.
                            }) {
                                Label("Add a new Zettel", systemImage: "plus.square.fill.on.square.fill")}
                       
                        }
                      
                        Button(action: {
                            showingSheet = false
                            isPresented = true
                        }) {
                            Label("Zettel History", systemImage: "square.stack.fill")}
                    }
                    .font(.title)
                    .labelStyle(.iconOnly)
                    .padding(10)
                }
                
                
                
            }
            
        }
        
        
        
        
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //        ContentView()
        //            .preferredColorScheme(.dark)
        ContentView(zettelData: ZettelData(), isPresented: .constant(false))
            .preferredColorScheme(.light)
        
    }
}
