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
    
    @AppStorage("about") var about = initAboutText
    
    var screenSize: CGSize
    
    private var textSize: CGFloat {
        return makeTextSize(for: zettelData.zettel.first?.fontSize ?? .huge)
    }
    
    let isPad = UIDevice.current.userInterfaceIdiom == .pad
        
    var body: some View {
        let frameSize = geoMagic(width: screenSize.width, height: screenSize.height, showingSheet: showingSheet, widgetSize: zettelData.zettel.first?.showSize ?? .small)
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                    .onTapGesture {
                        editorIsFocused = nil
                    }
                    
                
                VStack {

                    Spacer()

                    ZStack {
                        RoundedRectangle(cornerRadius: 21.67, style: .continuous)
                            .fill(Color("WidgetColor"))
                        
                           ZettelStack(text: zettelData.zettel[0].text, textSize: textSize)
                            
                            .onAppear() {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                                    editorIsFocused = .field
                                }
                            }

                        if showingSheet {
                            ZStack {
                                RoundedRectangle(cornerRadius: 21.67, style: .continuous)
                                    .fill(Color("WidgetColor"))
                                
                                    TextEditor(text: $about)
                                        .scrollContentBackground(.hidden)
                                        .font(.system(size: textSize))
                                        .minimumScaleFactor(0.4)
                                        .padding()
                                        
                                

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
                    .frame(width: frameSize.width, height: frameSize.height)
                    .onTapGesture {
                        editorIsFocused = .field
                    }
                    
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
                        if !isPad {
                            ZettelMenu(showingSheet: $showingSheet, zettel: $zettelData.zettel[0])
                        }
                    }
                    .padding(.trailing)
                .padding(.top)

                
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    HStack(alignment: .bottom) {
                        
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
                        
                        if showingSheet {
                            
                            Button(action: {
                                about = initAboutText
                            }) {
                                Label("Reset About", systemImage: "arrow.counterclockwise.square.fill")
                            }
                            .disabled(about == initAboutText)
                            .padding(.horizontal)
                            
                        } else {
                            
                            ZStack {
                                TextEditor(text: $zettelData.zettel[0].text)
                                    .scrollContentBackground(.hidden)
                                    .font(.system(size: CGFloat(12)))
                                    .minimumScaleFactor(0.5)
                                    .focused($editorIsFocused, equals: .field)
                                    .padding(.horizontal)
                                
//                                VStack {
//                                    Spacer()
//                                    HStack {
//                                        Spacer()
//                                        if zettelData.zettel[0].text.count > 0 {
//                                            Button(action: {
//                                                zettelData.zettel[0].text = ""
//                                                editorIsFocused = .field
//                                            }) {
//                                                Label("Erase Text", systemImage: "xmark.circle.fill")}
//                                            .labelStyle(.iconOnly)
//                                            .font(.system(size: CGFloat(14)))
//                                            .contentShape(Rectangle())
//                                            .padding(.horizontal, 9)
//                                            .padding(.bottom, 5)
//                                        }
//                                    }
//                                }
                            }
                            
                            .frame(width: screenSize.width/2, height: screenSize.height/8)
                            //                                                    .opacity(editorIsFocused == .field ? 1.0 : 0.0)
                        }
                        Button(action: {
                            showingSheet = false
                            isPresented = true
                        }) {
                            Label("Zettel History", systemImage: "square.stack.fill")}
                        .padding(.leading)
                        
                        if isPad {
                            ZettelMenu(showingSheet: $showingSheet, zettel: $zettelData.zettel[0], isPad: true)
                                .padding(.leading)
                        }

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
