//
//  ContentView.swift
//  SwiftUIViewInspector
//
//  Created by Vid Tadel on 1/24/23.
//

import SwiftUI
import Charts
import SwiftUIViewInspector

struct ContentView: View {

	enum ChartType: String, CaseIterable, Identifiable {
		var id: Self {
			return self
		}

		case bar = "Bar chart"
		case rectangle = "Rectangle chart"
	}

	enum Shape: String {
		case square = "Square"
		case circle = "Circle"
		case triangle = "Triangle"
	}

	struct ShapeItem: Identifiable {
		var shape: Shape
		var count: Double
		var color: Color
		var id = UUID()
	}

	@State private var chartType: ChartType = .bar

	let data: [ShapeItem] = [
		.init(shape: .square, count: 2, color: .pink),
		.init(shape: .circle, count: 1, color: .yellow),
		.init(shape: .triangle, count: 4, color: .gray)
	]

    var body: some View {
        VStack {
			Text("Shapes")
				.font(.system(size: 36, weight: .bold))
			Spacer()
			HStack(spacing: 40) {
				ForEach(data) { item in
					VStack {
						Text(item.shape.rawValue)
							.font(.system(size: 20, weight: .bold))

						switch item.shape {
						case .square:
							Rectangle()
								.fill(item.color)
								.frame(width: 50, height: 50)
						case .circle:
							Circle()
								.fill(item.color)
								.frame(width: 50, height: 50)
						case .triangle:
							Triangle()
								.fill(item.color)
								.frame(width: 50, height: 50)
						}
					}
				}
			}
			Spacer()
			Picker("Chart type", selection: $chartType) {
				ForEach(ChartType.allCases) { type in
					Text(type.rawValue)
						.tag(type)
				}
			}
			.pickerStyle(.segmented)
			Spacer()
				.frame(height: 20)
			Chart {
				ForEach(data) { item in
					switch chartType {
					case .bar:
						BarMark(
							x: .value("Shape Type", item.shape.rawValue),
							y: .value("Total Count", item.count)
						)
						.foregroundStyle(item.color)
					case .rectangle:
						RectangleMark(
							x: .value("Shape Type", item.shape.rawValue),
							y: .value("Total Count", item.count)
						)
						.foregroundStyle(item.color)
					}
				}
			}
			.frame(height: 300)
        }
        .padding()
        .inspectable()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
