//
//  ZettelWidget.swift
//  ZettelWidget
//
//  Created by Simon Lang on 11.11.21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    private static var documentsFolder: URL {
        let appIdentifier = "group.zettel"
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appIdentifier)!
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("zettel.data")
    }
    
    func load() -> [Zettel] {
        
        guard let data = try? Data(contentsOf: Self.fileURL) else {
            print("Couldn't load data in intent handler")
            return [Zettel(text: "Your notes on the Zettel", showSize: .small, fontSize: .normal)]
        }
        
        guard let zettel = try? JSONDecoder().decode([Zettel].self, from: data) else {
            fatalError("Couldn't decode saved codes data")
        }
        
        return zettel
        
    }
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), zettel: [Zettel(text: "Your notes on the Zettel. In a Zettel widget, on your Home Screen, for you to check and edit!", showSize: .small, fontSize: .compact)])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), zettel: [Zettel(text: "Your notes on the Zettel. In a Zettel widget, on your Home Screen, for you to check and edit!", showSize: .small, fontSize: .compact)])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let zettel = load()
        
        let entries = [SimpleEntry(date: Date(), zettel: zettel)]
        
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let zettel: [Zettel]
}

struct ZettelWidgetEntryView : View {
    @Environment(\.widgetRenderingMode) var renderingMode
    var entry: Provider.Entry
    
    private var textSize: CGFloat {
        if entry.zettel.first?.fontSize == .large {
            return CGFloat(20)
        }
        if entry.zettel.first?.fontSize == .compact {
            return CGFloat(13)
        }
        else {
            return CGFloat(16)
        }
    }

    var body: some View {
        ZStack {
            switch renderingMode {
            case .accented:
                VStack {
                    Text(entry.zettel[0].text)
                        .font(.system(size: textSize))
                        .widgetAccentable()
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .layoutPriority(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                    .containerBackground(for: .widget) {
                                    Color("WidgetColor")
                                }
                    
            default:
                VStack {
                    Text(entry.zettel[0].text)
                        .font(.system(size: textSize))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .layoutPriority(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                    .containerBackground(for: .widget) {
                                    Color("WidgetColor")
                                }
            }
        }
    }
}

@main
struct ZettelWidget: Widget {
    let kind: String = "ZettelWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ZettelWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Zettel Widget")
        .description("Shows your Zettel notes in a widget.")
    }
}

struct ZettelWidget_Previews: PreviewProvider {
    static var previews: some View {
        ZettelWidgetEntryView(entry: SimpleEntry(date: Date(), zettel: [Zettel(text: "Your notes on the Zettel", showSize: .small, fontSize: .normal)]))
//            .preferredColorScheme(.dark)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
