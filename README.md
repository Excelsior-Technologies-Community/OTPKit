# OTPKit

OTPKit is a lightweight SwiftUI package that provides a **stable, reusable OTP (One-Time Password) input view**.
It supports **4-digit / 6-digit OTP**, numeric input only, SMS auto-fill support, and gives developers **direct access to the entered OTP value** using `@State` and `@Binding`.
 
---

## Requirements

* iOS 15+
* SwiftUI
* Swift Package Manager

---

## Installation (Swift Package Manager)

### Step 1: Add the package

1. Open your project in Xcode
2. Go to **File → Add Packages…**
3. Paste your repository URL:

   ```
   https://github.com/Excelsior-Technologies-Community/OTPKit
   ```
4. Select the latest version
5. Add **OTPKit** to your target

---

## Importing OTPKit

In any SwiftUI file where you want to use OTP:

```swift
import OTPKit
```

---

## Basic Usage (Most Important Part)

### Step 1: Add State Variables

In your `ContentView` (or any SwiftUI view), first add these properties:

```swift
@State private var enteredPassword = ""
@State private var isVerifying = false
```

Explanation:

* `enteredPassword` will always contain the OTP typed by the user
* You can directly use this value for verification
* `isVerifying` can be used for loading state or API call

---

### Step 2: Add OTPView

Use `OTPView` by passing the binding of your state variable:

```swift
OTPView(
    otpCode: $enteredPassword,
    length: 4,
    activeColor: .green
)
```

What this does:

* `otpCode` binds the OTP value to `enteredPassword`
* `length: 4` creates a 4-digit OTP UI
* `activeColor` controls the active box border color

You can also use `length: 6` for a 6-digit OTP.

---

### Step 3: Access the OTP Value

You can access the entered OTP **anytime** using:

```swift
enteredPassword
```

Example:

```swift
if enteredPassword.count == 4 {
    print("OTP Entered:", enteredPassword)
}
```

This makes OTPKit very easy to integrate with:

* Login flows
* Verification screens
* API calls
* Local validation

---

## Full Working Example

```swift
import SwiftUI
import OTPKit


struct ContentView: View {

    // OTP value is stored here
    @State private var enteredPassword = ""
    @State private var isVerifying = false

    var body: some View {
        VStack(spacing: 40) {

            // OTP INPUT
            OTPView(
                otpCode: $enteredPassword,
                length: 4,
                activeColor: .green
            )

            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    hideKeyboard()
                }
            }
        }
    }

    // MARK: - Keyboard Dismiss
    private func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
```

---

## Customization Options

| Parameter       | Description                |
| --------------- | -------------------------- |
| `otpCode`       | Binding to your OTP string |
| `length`        | OTP length (4 or 6)        |
| `activeColor`   | Active box border color    |
| `inactiveColor` | Inactive box border color  |

Example:

```swift
OTPView(
    otpCode: $enteredPassword,
    length: 6,
    activeColor: .blue,
    inactiveColor: .gray
)
```

---

## How OTPKit Works (Short)

* Uses a hidden input field for stable keyboard handling
* Displays custom SwiftUI boxes for each digit
* Filters input to numeric only
* Supports SMS OTP auto-fill
* Avoids SwiftUI focus bugs

 
 Created by **Noman Belim**

---
 