import SwiftUI

struct CustomVideoControlsView: View {
    @Binding var progress : Float
    @Binding var isSliderMoving : Bool
    @Binding var isMuted : Bool
    var onTapMute: (() -> Void)
    
    var body: some View {
        HStack {
            Slider(value: $progress, onEditingChanged: { editing in
                isSliderMoving = editing
            })
            .padding()
            
            Button(action: onTapMute) {
                Image(systemName: isMuted ? Constants.muteIconName : Constants.notMutedIconName)
                    .foregroundColor(.black)
            }
            .padding()
        }
        .background(.white)
        .cornerRadius(Constants.cornerRadius)
    }
}

private extension CustomVideoControlsView {
    enum Constants {
        static let muteIconName = "speaker.slash.fill"
        static let notMutedIconName = "speaker.fill"
        static let cornerRadius: CGFloat = 12
    }
}

struct CustomVideoControlsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomVideoControlsView(
            progress: .constant(0.5),
            isSliderMoving: .constant(false),
            isMuted: .constant(false),
            onTapMute: {}
        )
    }
}
