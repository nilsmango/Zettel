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
    
    @AppStorage("about") var about = "About\nproject7III makes useful things.\nFind us: project7iii.com\nWrite to us: hi@project7iii.com\n\nHow to add a Zettel widget\n1. Go to the Home Screen\n2. Long press to enter wiggle mode\n3. Tap the +\n4. Search for Zettel\n5. Add the Zettel widget of your choice\n\nNote: The widget will always show the Zettel you worked on last.\n\nChangelog:\n0.1 made with ❤️ by Nils Mango (nilsmango.ch) in Switzerland, 2021-2022."
    
    var screenSize: CGSize
    
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
    
    var body: some View {
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
                        RoundedRectangle(cornerRadius: 21.67, style: .continuous)
                            .fill(Color("WidgetColor"))
                        
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
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                if zettelData.zettel[0].text.count > 0 {
                                    Button(action: { zettelData.zettel[0].text = ""
                                   }) {
                                        Label("Erase Text", systemImage: "xmark.circle.fill")}
                                    .labelStyle(.iconOnly)
                                    .padding(9)
                                }
                                
                            }
                            
                        }

                        if showingSheet {
                            ZStack {
                                RoundedRectangle(cornerRadius: 21.67, style: .continuous)
                                    .fill(Color("WidgetColor"))
                                
                                    TextEditor(text: $about)
                                        .scrollContentBackground(.hidden)
                                        .font(.system(size: textSize))
                                        .padding(EdgeInsets(top: 11, leading: 12, bottom: 13, trailing: 12))
                                        
                                

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
                    .frame(width: geoMagic(width: screenSize.width, height: screenSize.height, showingSheet: showingSheet, widgetSize: zettelData.zettel.first?.showSize ?? .small).width, height: geoMagic(width: screenSize.width, height: screenSize.height, showingSheet: showingSheet, widgetSize: zettelData.zettel.first?.showSize ?? .small).height + 1)
                    Spacer()
                }
                
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
                            Button(action: {
                                // TODO: Add donation thing
                            } ) {
                                Label("Tip us 1 USD!", systemImage: "heart")
                            }
                        } label: {
                            Label("Options", systemImage: "ellipsis.circle.fill")
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
                            .padding(.trailing)
                        } else {
                            Button(action: {
                                zettelData.zettel.insert(Zettel(text: "", showSize: zettelData.zettel[0].showSize, fontSize: zettelData.zettel[0].fontSize), at: 0)
                                // insert a new empty zettel at 0.
                            }) {
                                Label("Add a new Zettel", systemImage: "plus.square.fill.on.square.fill")}
                            .padding(.trailing)
                       
                        }
                        
                        
                        
                        Button(action: {
                            showingSheet = false
                            isPresented = true
                        }) {
                            Label("Zettel History", systemImage: "square.stack.fill")}
                        .padding(.leading)
                        
                    }
                    .font(.title)
                    .labelStyle(.iconOnly)
                    .padding(10)
                }
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //        ContentView()
        //            .preferredColorScheme(.dark)
        ContentView(zettelData: ZettelData(), isPresented: .constant(false), screenSize: UIScreen.main.bounds.size)
            .preferredColorScheme(.light)
            .background(Color("BackgroundColor"))
    }
}
