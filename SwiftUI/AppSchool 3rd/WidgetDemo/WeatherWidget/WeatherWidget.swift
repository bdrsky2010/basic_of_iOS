//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Minjae Kim on 12/28/23.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
		WeatherEntry(date: Date(), city: "London", temperature: 89,
			  description: "Thunder Storm", icon: "cloud.bolt.rain",
					image: "thunder", url: thunderURL)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> WeatherEntry {
		WeatherEntry(date: Date(), city: "London", temperature: 89,
			  description: "Thunder Storm", icon: "cloud.bolt.rain",
					image: "thunder", url: thunderURL)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<WeatherEntry> {
		
		// 위치 정보를 추출하여
		var chosenLocation: LocationData
		
		if configuration.locations == .londonUK {
			chosenLocation = .london
		} else {
			chosenLocation = .miami
		}
		
        var entries: [WeatherEntry] = []
		var eventDate = Date()
		let halfMinute: TimeInterval = 1
		
		// 일치하는 타임라인을 반환
		for var entry in chosenLocation.timeline {
			entry.date = eventDate
			eventDate += halfMinute
			entries.append(entry)
		}

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry

	@Environment(\.widgetFamily) var widgetFamily
	
    var body: some View {
		ZStack {
			Color("weatherBackgroundColor")
			
			HStack {
				WeatherSubView(entry: entry)
				if widgetFamily == .systemMedium {
					Image(entry.image)
						.resizable()
				}
			}
		}
		.widgetURL(entry.url)
    }
}

struct WeatherSubView: View {
	var entry: WeatherEntry
	var body: some View {
		VStack {
			VStack {
				Text("\(entry.city)")
					.font(.title)
				Image(systemName: entry.icon)
					.font(.largeTitle)
				Text("\(entry.description)")
					.frame(minWidth: 125, minHeight: nil)
			}
			.padding(.bottom, 2)
			.background(ContainerRelativeShape().fill(Color("weatherInsetColor")))
			
			Label("\(entry.temperature)F", image: "tempeature")
		}
		.foregroundStyle(.white)
		.padding()
	}
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
		// 위젯 옵션에 내용을 기술(변경)
		.configurationDisplayName("My Weather Widget")
		.description("A demo weather widget")
		// 위젯 크기 지원
		.supportedFamilies([.systemSmall, .systemMedium])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    WeatherWidget()
} timeline: {
	WeatherEntry(date: Date(), city: "London", temperature: 89,
		  description: "Thunder Storm", icon: "cloud.bolt.rain",
				image: "thunder", url: thunderURL)
	WeatherEntry(date: Date(), city: "Miami", temperature: 81,
		  description: "Thunder Storm", icon: "cloud.bolt.rain",
				image: "thunder", url: thunderURL)
}
