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
        SimpleEntry(date: Date(), namesallah: "Names of Allah")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), namesallah: "Names of Allah")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, namesallah: MyDataProvider.namesallah())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let namesallah: String
}

struct TurbahWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Color.green.edgesIgnoringSafeArea(.all)
            Text(entry.namesallah)
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
        TurbahWidgetEntryView(entry: SimpleEntry(date: Date(), namesallah: "Names of Allah"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

class MyDataProvider{
    static func namesallah()-> String{
        let strings = [
        "1) AR-RAHMAAN - The Beneficent",
        "2) AR-RAHEEM - The Merciful",
        "3) AL-MALIK - The Eternal Lord",
        "4) AL-QUDDUS - The Most Sacred",
        "5) AS-SALAM - The embodiment of Peace",
        "6) AL-MU’MIN - The Infuser of Faith",
        "7) AL-MUHAYMIN - The Preserver of Safety",
        "8) AL-AZIZ	- All Mighty",
        "9) AL-JABBAR - The Compeller, The Restorer",
        "10) AL-MUTAKABBIR - The Supreme, The Majestic",
        "11) AL-KHAALIQ	- The Creator, The Maker",
        "12) AL-BAARI - The Evolver",
        "13) AL-MUSAWWIR - The Fashioner",
        "14) AL-GHAFFAR	- The Great Forgiver",
        "15) AL-QAHHAR - The All-Prevailing One",
        "16) AL-WAHHAAB	- The Supreme Bestower",
        "17) AR-RAZZAAQ	- The Provider",
        "18) AL-FATTAAH	- The Supreme Solver",
        "19) AL-‘ALEEM	- The All-Knowing",
        "20) AL-QAABID - The Withholder",
        "21) AL-BAASIT - The Extender",
        "22) AL-KHAAFIDH - The Reducer",
        "23) AR-RAAFI’ - The Exalter, The Elevator",
        "24) AL-MU’IZZ - The Honourer, The Bestower",
        "25) AL-MUZIL - The Dishonourer, The Humiliator",
        "26) AS-SAMEE’ - The All-Hearing",
        "27) AL-BASEER - The All-Seeing",
        "28) AL-HAKAM - The Impartial Judge",
        "29) AL-‘ADL - The Utterly Just",
        "30) AL-LATEEF - The Subtle One, The Most Gentle",
        "31) AL-KHABEER	- The All-Aware",
        "32) AL-HALEEM - The Most Forbearing",
        "33) AL-‘AZEEM - The Magnificent, The Supreme",
        "34) AL-GHAFOOR	- The Great Forgiver",
        "35) ASH-SHAKOOR - The Most Appreciative",
        "36) AL-‘ALEE - The Most High, The Exalted",
        "37) AL-KABEER - The Preserver, The All-Heedful and All-Protecting",
        "38) AL-HAFEEDH	- The Preserver",
        "39) AL-MUQEET - The Sustainer",
        "40) AL-HASEEB - The Reckoner",
        "41) AL-JALEEL - The Majestic",
        "42) AL-KAREEM - The Most Generous, The Most Esteemed",
        "43) AR-RAQEEB - The Watchful",
        "44) AL-MUJEEB - The Responsive One",
        "45) AL-WAASI’ - The All-Encompassing, the Boundless",
        "46) AL-HAKEEM - The All-Wise",
        "47) AL-WADUD - The Most Loving",
        "48) AL-MAJEED - The Glorious, The Most Honorable",
        "49) AL-BA’ITH - The Infuser of New Life",
        "50) ASH-SHAHEED - The All Observing Witnessing",
        "51) AL-HAQQ - The Absolute Truth",
        "52) AL-WAKEEL - The Trustee, The Disposer of Affairs",
        "53) AL-QAWIYY - The All-Strong",
        "54) AL-MATEEN - The Firm, The Steadfast",
        "55) AL-WALIYY - The Protecting Associatey",
        "56) AL-HAMEED - The Praiseworthy",
        "57) AL-MUHSEE - The All-Enumerating, The Counter",
        "58) AL-MUBDI - The Originator, The Initiator",
        "59) AL-MUEED - The Restorer, The Reinstater",
        "60) AL-MUHYI - The Giver of Life",
        "61) AL-MUMEET - The Inflicter of Death",
        "62) AL-HAYY - The Ever-Living",
        "63) AL-QAYYOOM	- The Sustainer, The Self-Subsisting",
        "64) AL-WAAJID - The Perceiver",
        "65) AL-MAAJID - The Illustrious, the Magnificent",
        "66) AL-WAAHID - The One",
        "67) AL-AHAD - The Unique, The Only One",
        "68) AS-SAMAD - The Eternal, Satisfier of Needs",
        "69) AL-QADEER - The Omnipotent One",
        "70) AL-MUQTADIR - The Powerful",
        "71) AL-MUQADDIM - The Expediter, The Promoter",
        "72) AL-MU’AKHKHIR - The Delayer",
        "73) AL-AWWAL - The First",
        "74) AL-AAKHIR - The Last",
        "75) AZ-ZAAHIR - The Manifest",
        "76) AL-BAATIN - The Hidden One, Knower of the Hidden",
        "77) AL-WAALI - The Governor, The Patron",
        "78) AL-MUTA’ALI - The Self Exalted",
        "79) AL-BARR - The Source of All Goodness",
        "80) AT-TAWWAB - The Ever-Pardoning, The Relenting",
        "81) AL-MUNTAQIM - The Avenger",
        "82) AL-‘AFUWW - The Pardoner",
        "83) AR-RA’OOF - The Most Kind",
        "84) MAALIK-UL-MULK	- Master of the Kingdom, Owner of the Dominion",
        "85) DHUL-JALAALI WAL-IKRAAM - Possessor of Glory and Honour, Lord of Majesty and Generosity",
        "86) AL-MUQSIT - The Just One",
        "87) AL-JAAMI’ - The Gatherer, the Uniter",
        "88) AL-GHANIYY - The Self-Sufficient, The Wealthy",
        "89) AL-MUGHNI - The Enricher",
        "90) AL-MANI’ - The Withholder",
        "91) AD-DHARR - The Distresser",
        "92) AN-NAFI’ - The Propitious, the Benefactor",
        "93) AN-NUR	- The Light, The Illuminator",
        "94) AL-HAADI - The Guide",
        "95) AL-BADEE’ - The Incomparable Originator",
        "96) AL-BAAQI - The Everlasting",
        "97) AL-WAARITH	- The Inheritor, The Heir",
        "98) AR-RASHEED	- The Guide, Infallible Teacher",
        "99) AS-SABOOR - The Forbearing, The Patient",
        ]
        return strings.randomElement()!
    }
}
