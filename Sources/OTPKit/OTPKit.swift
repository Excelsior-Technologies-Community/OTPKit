//
//  OTPView.swift
//  DeliveryTracking
//
//  Created by Noman belim on 19/12/25.
//

import Foundation
import SwiftUI

import SwiftUI
import Combine

import SwiftUI

public struct OTPView: View {
    // MARK: - CONFIG
    let length: Int
    let activeColor: Color
    let inactiveColor: Color
    
    // MARK: - BINDING (This is how the developer gets the value)
    @Binding var otpCode: String

    // MARK: - INTERNAL STATE
    @FocusState private var isFocused: Bool

    public init(
        otpCode: Binding<String>,
        length: Int = 6,
        activeColor: Color = .blue,
        inactiveColor: Color = .gray
    ) {
        self._otpCode = otpCode
        self.length = length
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
    }

    public var body: some View {
        ZStack {
            // Hidden TextField to capture input
            TextField("", text: $otpCode)
                .frame(width: 0, height: 0)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode) // Auto-fill from SMS
                .focused($isFocused)
                .onChange(of: otpCode) { newValue in
                    // Clean input: only numbers and max length
                    let filtered = newValue.filter { $0.isNumber }
                    if filtered.count > length {
                        otpCode = String(filtered.prefix(length))
                    } else {
                        otpCode = filtered
                    }
                }

            // Visual Boxes
            HStack(spacing: 12) {
                ForEach(0..<length, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(getBorderColor(at: index), lineWidth: 2)
                            .frame(width: 45, height: 55)
                        
                        Text(getCharacter(at: index))
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
    private func getBorderColor(at index: Int) -> Color {
        if index == otpCode.count && isFocused {
            return activeColor
        }
        return inactiveColor
    }

    private func getCharacter(at index: Int) -> String {
        guard index < otpCode.count else { return "" }
        let startIndex = otpCode.startIndex
        return String(otpCode[otpCode.index(startIndex, offsetBy: index)])
    }
}



