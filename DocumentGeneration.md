#Generating AppleDoc in XCode

## Installation

Install AppleDoc from [https://github.com/tomaz/appledoc](https://github.com/tomaz/appledoc) (follow the steps described in there).

## Generation

In order to integrate the AppleDoc with XCode, follow [these instructions](https://github.com/tomaz/appledoc/blob/master/XcodeIntegrationScript.markdown).

If you want to generate the documentation every time you build your project, set up the build scheme by adding *Documentation* target into the existing scheme. You can reach that by clicking Xcode menu > Product > Edit Scheme menu item.

The docs are saved at `/Users/YourUserName/Library/Developer/Shared/Documentation/DocSets/com.yourcompanysite.YourProjectName.docset`

## Visualization

1. Go to the docset folder (`/Users/YourUserName/Library/Developer/Shared/Documentation/DocSets/com.yourcompanysite.YourProjectName.docset`).

2. In the Finder right-click on the docset file for context menu.

3. Choose "Show package content".

4. Navigate to "Contents/Resources/Documents".

5. Open "index.html" with any browser.

