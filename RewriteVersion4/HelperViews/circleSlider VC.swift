//
//  circleSlider VC.swift
//  circleSlider
//
//  Created by trevor wilson on 2024-01-20.
//

//

import SwiftUI



struct CircleSliderVC: View {
    //@State var sliderValue: CGFloat = 0.0
    @State private var angleValue: CGFloat
    @State private var sliderValue: CGFloat

    var minimunSliderValue : CGFloat
    var maximunSliderValue : CGFloat
    var minimunRange : CGFloat
    var maximunRange : CGFloat
    var totalValue : CGFloat
    var knobRadius : CGFloat
    var radius : CGFloat
    var initialSliderValue : CGFloat
    var valueUnit: String
    
    //var sliderValue : CGFloat
    
    init(minimunSliderValue: CGFloat, maximunSliderValue: CGFloat, minimunRange: CGFloat, maximunRange: CGFloat, totalValue: CGFloat, knobRadius: CGFloat, radius: CGFloat, initialSliderValue: CGFloat, valueUnit: String) {
        self.minimunSliderValue = minimunSliderValue
        self.maximunSliderValue = maximunSliderValue
        self.minimunRange = minimunRange
        self.maximunRange = maximunRange
        self.totalValue = totalValue
        self.knobRadius = knobRadius
        self.radius = radius
        self.initialSliderValue = initialSliderValue
        self.sliderValue = initialSliderValue // Initialize the sliderValue state variable
        self.valueUnit = valueUnit
        angleValue = (Double(360/totalValue)*initialSliderValue)
    }

    var body: some View {
        ZStack {
            Circle()
                .frame(width: self.radius * 2, height: self.radius * 2)
                .scaleEffect(1.20)
            
            Circle()
                .stroke(Color.gray,
                        style: StrokeStyle(lineWidth: 3, lineCap: .butt, dash: [3, 23.18]))
                .frame(width: self.radius * 2, height: self.radius * 2)
            
            Circle()
                .trim(from: 0.0, to: self.sliderValue/self.totalValue)
                .stroke(self.sliderValue < self.maximunSliderValue/2 ? Color.blue : Color.red, lineWidth: 4)
                .frame(width: self.radius * 2, height: self.radius * 2)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .fill(self.sliderValue < self.maximunSliderValue/2 ? Color.blue : Color.red)
                .frame(width: self.knobRadius * 2, height: self.knobRadius * 2)
                .padding(10)
                .offset(y: -self.radius)
                .rotationEffect(Angle.degrees(Double(angleValue)))
                .gesture(DragGesture(minimumDistance: 0.0)
                            .onChanged({ value in
                                change(location: value.location)
                            }))
            
            Text("\(String.init(format: "%.0f", self.sliderValue)) \(valueUnit)")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
        }
    }
    
    private func change(location: CGPoint) {
        // creating vector from location point
        let vector = CGVector(dx: location.x, dy: location.y)
        
        // geting angle in radian need to subtract the knob radius and padding from the dy and dx
        let angle = atan2(vector.dy - (self.knobRadius + 10), vector.dx - (self.knobRadius + 10)) + .pi/2.0
        
        // convert angle range from (-pi to pi) to (0 to 2pi)
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        // convert angle value to temperature value
        let value = fixedAngle / (2.0 * .pi) * self.totalValue
        
        if value >= self.minimunSliderValue && value <= self.maximunSliderValue {
            self.sliderValue = value
            angleValue = fixedAngle * 180 / .pi // converting to degree
        }
    }
}



struct Content_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView()
        CircleSliderVC(minimunSliderValue: 0, maximunSliderValue: 40, minimunRange: 100, maximunRange: 200, totalValue: 40, knobRadius: 15, radius: 75, initialSliderValue: 10, valueUnit: "?")
    }
}
