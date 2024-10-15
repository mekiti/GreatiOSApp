import SwiftUI

struct EntryFieldView: View {
    let placeHolder: String
    let icon: ImageResource
    var isSecure = false

    @State private var text = ""
    @FocusState var isInFocus: Bool

    private var opacity: CGFloat {
        isInFocus ? 1 : 0.6
    }

    var body: some View {
        HStack(spacing: 0) {
            Image(icon)
                .resizable()
                .frame(
                    width: Constants.texfieldIconSize,
                    height: Constants.texfieldIconSize
                )
                .padding(.leading, Constants.EntryFieldView.padding)
                .opacity(opacity)
            Group {
                if isSecure {
                    SecureField(placeHolder, text: $text)
                } else {
                    TextField(placeHolder, text: $text)
                }
            }
            .focused($isInFocus)
            .keyboardType(.asciiCapable)
            .autocorrectionDisabled()
            .padding(Constants.EntryFieldView.padding)
        }
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(.textFieldBackground)
        )
    }
}

#Preview {
    VStack {
        EntryFieldView(placeHolder: "placeHolder", icon: .lockIcon)
        EntryFieldView(placeHolder: "placeHolder", icon: .lockIcon, isSecure: true)
    }
    .padding()
}
