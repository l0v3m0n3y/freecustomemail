# freecustomemail
web-api for freecustom.email Create a free temp mail address in seconds. No signup, no ads, forever free. Real-time inbox with custom domain support and automatic OTP extraction.
# main
```swift
import Foundation
let client = Freecustomemail()

do {
    let emailInfo = try await client.create_email(email: "email")
    print(emailInfo)
} catch {
    print("Error: \(error)")
}

```

# Launch (your script)
```
swiftc -o freecustom freecustomemail.swift main.swift
./freecustom
```
