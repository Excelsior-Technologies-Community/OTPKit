//
//
//  Created by Noman belim
//

import Foundation
import SwiftUI
import Combine
public struct OTPView: View {

    // MARK: - CONFIG
    let length: Int
    let boxSize: CGFloat
    let activeColor: Color
    let inactiveColor: Color

    // MARK: - BINDING
    @Binding var otpCode: String

    // MARK: - INTERNAL STATE
    @FocusState private var isFocused: Bool

    public init(
        otpCode: Binding<String>,
        length: Int = 6,
        boxSize: CGFloat = 48,
        activeColor: Color = .blue,
        inactiveColor: Color = .gray
    ) {
        self._otpCode = otpCode
        self.length = length
        self.boxSize = boxSize
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
    }

    public var body: some View {
        ZStack {

            // Hidden TextField (same square size)
            TextField("", text: $otpCode)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($isFocused)
                .opacity(0.01)
                .frame(width: boxSize, height: boxSize)
                .onChange(of: otpCode) { newValue in
                    let filtered = newValue.filter { $0.isNumber }
                    otpCode = String(filtered.prefix(length))
                }

            // Visual Boxes
            HStack(spacing: 12) {
                ForEach(0..<length, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 8) // 👈 square corners
                            .stroke(
                                index == otpCode.count && isFocused
                                    ? activeColor
                                    : inactiveColor,
                                lineWidth: 2
                            )
                            .frame(width: boxSize, height: boxSize)

                        Text(character(at: index))
                            .font(.title2.bold())
                    }
                    .onTapGesture {
                        isFocused = true
                    }
                }
            }
        }
        .onAppear {
            isFocused = true
        }
    }

    // MARK: - HELPERS
    private func character(at index: Int) -> String {
        guard index < otpCode.count else { return "" }
        return String(Array(otpCode)[index])
    }
}



