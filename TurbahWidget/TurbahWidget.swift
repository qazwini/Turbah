//
//  TurbahWidget.swift
//  TurbahWidget
//
//  Created by Ongar.dev 13/02/2023.
//  Copyright © 2023 MMQ. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), equations: "Names of Allah")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), equations: "Names of Allah")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, equations: MyDataProvider.getequations())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let equations: String
}

struct TurbahWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Color.green.edgesIgnoringSafeArea(.all)
            Text(entry.equations)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.largeTitle)
        }
    }
}

struct TurbahWidget: Widget {
    let kind: String = "TurbahWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TurbahWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Names of Allah")
        .description("Memorize the 99 names of Allah")
    }
}

struct TurbahWidget_Previews: PreviewProvider {
    static var previews: some View {
        TurbahWidgetEntryView(entry: SimpleEntry(date: Date(), equations: "Names of Allah"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

class MyDataProvider{
    static func getequations()-> String{
        let strings = [
        "1) AR-RAHMAAN - The Beneficent",
        ]
        return strings.randomElement()!
    }
}
