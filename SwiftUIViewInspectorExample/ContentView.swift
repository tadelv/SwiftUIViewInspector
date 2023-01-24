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

	var data: [ShapeItem] = [
		.init(type: "Rectangle", count: 2, color: .pink),
		.init(type: "Circle", count: 1, color: .yellow),
		.init(type: "Triangle", count: 4, color: .gray)
	]

    var body: some View {
        VStack {
			Text("Shapes")
				.font(.system(size: 36, weight: .bold))
			Spacer()
				.frame(height: 40)
			HStack(spacing: 20) {
				VStack {
					Text("Rectangle")
						.font(.system(size: 20, weight: .bold))
					Rectangle()
						.fill(.pink)
						.frame(width: 120, height: 50)
				}
				VStack {
					Text("Circle")
						.font(.system(size: 20, weight: .bold))
					Circle()
						.fill(.yellow)
						.frame(width: 50, height: 50)
				}
				VStack {
					Text("Triangle")
						.font(.system(size: 20, weight: .bold))
					Triangle()
						.fill(.gray)
						.frame(width: 50, height: 50)
				}
			}
			Spacer()
			Chart {
				ForEach(data) { shape in
					BarMark(
						x: .value("Shape Type", shape.type),
						y: .value("Total Count", shape.count)
					)
					.foregroundStyle(shape.color)
				}
			}
			.frame(height: 300)
        }
        .padding()
        .inspectable()
    }
}

struct Triangle: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.closeSubpath()
		return path
	}
}

struct ShapeItem: Identifiable {
	var type: String
	var count: Double
	var color: Color
	var id = UUID()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
