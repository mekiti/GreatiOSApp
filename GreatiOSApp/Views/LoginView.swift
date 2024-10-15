import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Image(.logo)
                    .padding(.bottom, Constants.imagePadding)
                EntryFieldView(placeHolder: Constants.usernameString, icon: .userIcon)
                    .padding(.bottom, Constants.entryFieldPadding)
                EntryFieldView(placeHolder: Constants.passwordString, icon: .lockIcon, isSecure: true)
                    .padding(.bottom, Constants.buttonPadding)
                Button {

                } label: {
                    Text(Constants.loginString)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.button)
            }
            .padding(Constants.loginPadding)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}

#Preview {
    LoginView()
}
