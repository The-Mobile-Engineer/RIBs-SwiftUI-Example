# Overview

This is an example of how to preserve the overall UI structure of UIKit view controllers and use SwiftUI on an as-needed basis in a RIBs codebase via UIHostingViewController embeds.

This approach allows for the most flexibility in your architecture, preserves RIB's structure of business scopes and UI handling and along with it allows you not to compromise on SwiftUI usage in your project.

This particular example has an implementation of a Login RIB with SwiftUI. SwiftUI in case of Login RIB is it's entire view. 

It is also possible to go the other way around to use SwiftUI only for a portion of your RIB's view or embed a UIKit view controller into a SwiftUI view. 

This example does not expand on those use cases. However, please let me know if you're interested and I'll add it to this repo and https://newsletter.mobileengineer.io/.

A more expanded and detailed explanation of how this SwiftUI implementation in RIBs works can be found in the following article: https://newsletter.mobileengineer.io/p/ribs-swiftui-uikit-navigation-with
