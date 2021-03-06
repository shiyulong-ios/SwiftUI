//
//  MeetingHeaderView.swift
//  SwiftUIPro
//
//  Created by 石玉龙 on 2021/1/6.
//

import SwiftUI

struct MeetingHeaderView: View {
    @Binding var secondsElapsed:Int
    @Binding var secondsRemaining:Int
    private var minutesRemaining:Int{
        secondsRemaining/60
    }
    private var minutesRemainingMetric:String{
        minutesRemaining==1 ? "minute" : "minutes"
    }
    private var progress:Double{
        guard secondsRemaining > 0 else {
            return 1
        }
        let totalSeconds=Double(secondsElapsed+secondsRemaining)
        return Double(secondsElapsed)/totalSeconds
    }
    let scurmColor: Color
    var body: some View {
        VStack{
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(scrumColor:scurmColor))
            HStack{
                VStack(alignment: .leading){
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage:"hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing){
                    Text("Seconds Remaining")
                        .font(.caption)
                    HStack{
                        Text("\(secondsRemaining)")
                        Image(systemName:"hourglass.tophalf.fill")
                    }
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Time remaining"))
        .accessibilityValue(Text("\(minutesRemaining) \(minutesRemainingMetric)"))
        .padding([.top,.horizontal])
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: .constant(60), secondsRemaining: .constant(180), scurmColor: DailyScrum.data[0].color)
            .previewLayout(.sizeThatFits)
    }
}
