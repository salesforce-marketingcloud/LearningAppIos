![Marketing Cloud](imgReadMe/marketing_cloud_logo.png)

# README

> Marketing Cloud Learning Apps are free to use but are not official Salesforce Marketing Cloud products and should be considered community projects. These apps are not officially tested or documented. For help on any Marketing Cloud Learning App, consult the Salesforce message boards or the issues section of this repository. Salesforce Marketing Cloud support is not available for these applications.

Make sure that you always use the latest version of the iOS Journey Builder for Apps SDK. The Learning App only supports SDK versions 4.4.0 and above.


<a name="0001"></a>
# About

This project provides a template for creating a mobile app (iOS) that uses the Journey Builder for Apps SDK.  It is also a UI for exploring the SDK's features and provides a mechanism to collect and send debugging information to learn about the workings of the SDK as you explore.


#Get Started

###Provision your Learning App with Apple

Provisioning ensures that users receive push messages from your app.  You must [provision your mobile app in the iOS Provisioning Panel](http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/provisioning/apple.html). The certificates issued in the process are valid for one year. Ensure that you repeat this procedure once per year before your certificates expire to maintain app functionality.

###Create your Application in App Center

To connect your iOS app to Marketing Cloud, [create a MobilePush app in App Center](http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/create-apps/create-apps-app-center.html). App Center is the central development console for using Fuel APIs and building Marketing Cloud apps.

###Add App Center Credentials to your Application
On iOS, we use an 'AppDelegate+ETPushConstants.m' file to contain the application credentials given by App Center. Inside the AppDelegate+ETPushConstants.m file, set the following:

**AppDelegate+ETPushConstants.m**

1. `kETAppID_Prod`: The App ID for your development app as defined in the App Center section of Marketing Cloud.

2. `kETAccessToken_Prod`: The Access Token for your development app as defined in the App Center section of Marketing Cloud.

Note: You can use different keys for the staging and testing phase and the production phase.  Staging and testing keys are called `kETAppID_Debug` and `kETAccessToken_Debug`.<a name="0002"></a>

#Resources

For more information, check out our [developer documentation](http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/).
