//
//  PushConstants.h
//  JB4A-SDK-iOS
//
//  JB4A iOS SDK GitHub Repository
//  https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/
//

/**
 Notification that is sent when a push fails for some reason.
 */
/** @constant ETPush Notifications Sent when the data request process has started */
#define ETRequestStarted                @"ETRequestStarted"
#define ETRequestNoData                 @"ETRequestNoData"
#define ETRequestFailed                 @"ETRequestFailed"
#define ETRequestComplete               @"ETRequestComplete"
#define ETRequestFailedOnLoadingResult  @"ETRequestFailedOnLoadingResult"
#define ETRequestServiceReturnedError   @"ETRequestServiceReturnedError"
#define ETRequestServiceResponseSuccess @"ETRequestServiceResponseSuccess"
#define ETRequestFinishedWithFailure    @"ETRequestFinishedWithFailure"

/**
  Constants for dealing with other stuff
  */
#define AppLifecycleForeground          @"AppLifecycleForeground"
#define AppLifecycleBackground          @"AppLifecycleBackground"

/**
 Geofence Constants
 */
#define ETLargeGeofence                 433 // Get it? 433 North Capitol. It's been a long journey getting here.
#define ETLargeGeofenceIdentifier       @"ExactTargetMagicGlobalFence"

/**
 Caches
 */
#define ET_TAG_CACHE                    @"ET_TAG_CACHE"
#define ET_SUBKEY_CACHE                 @"ET_SUBKEY_CACHE"
#define ET_ATTR_CACHE                   @"ET_ATTR_CACHE"

/**
 Deprecation warning declaration
 */
#define __DEPRECATED_WARNING(message) __attribute((deprecated(message)))

// Tracks the BOOL for each in NSUserDefaults
static NSString * const ETProximityServicesActive DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETProximityServicesActive";
static NSString * const ETLocationServicesActive  DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETLocationServicesActive";
static NSString * const ETCloudPagesActive        DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETCloudPagesActive";
static NSString * const ETAnalyticsActive         DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETAnalyticsActive";
static NSString * const ETPIAnalyticsActive       DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETPIAnalyticsActive";

/**
 Push Origination State
 */
typedef NS_ENUM (NSUInteger, pushOriginationState){
    /** Initial enum value  */
    firstPushOriginationStateIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 0,
    /** PushOriginationStateBackground  */
    PushOriginationStateBackground DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = firstPushOriginationStateIndex,
    /** PushOriginationStateForeground  */
    PushOriginationStateForeground DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** Unknown state  */
    PushOriginationStateUnknown DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 999,
    /** lastPushOriginationStateIndex */
    lastPushOriginationStateIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = PushOriginationStateUnknown
};

/**
 configureSDKWithAppID errors
 */
typedef NS_ENUM(NSUInteger, configureSDKWithAppIDError) {
    /** Initial enum value  */
    firstconfigureSDKWithAppIDIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 0,
    /** configureSDKWithAppIDNoError  */
    configureSDKWithAppIDNoError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = firstconfigureSDKWithAppIDIndex,
    /** configureSDKWithAppIDInvalidAppIDError  */
    configureSDKWithAppIDInvalidAppIDError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDInvalidAccessTokenError  */
    configureSDKWithAppIDInvalidAccessTokenError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDUnableToReadRandomError  */
    configureSDKWithAppIDUnableToReadRandomError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDDatabaseAccessError  */
    configureSDKWithAppIDDatabaseAccessError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDUnableToKeyDatabaseError  */
    configureSDKWithAppIDUnableToKeyDatabaseError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDCCKeyDerivationPBKDFError  */
    configureSDKWithAppIDCCKeyDerivationPBKDFError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDCCSymmetricKeyWrapError  */
    configureSDKWithAppIDCCSymmetricKeyWrapError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDCCSymmetricKeyUnwrapError  */
    configureSDKWithAppIDCCSymmetricKeyUnwrapError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDKeyChainError  */
    configureSDKWithAppIDKeyChainError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDUnableToReadCertificateError  */
    configureSDKWithAppIDUnableToReadCertificateError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDRunOnceSimultaneouslyError  */
    configureSDKWithAppIDRunOnceSimultaneouslyError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDRunOnceError  */
    configureSDKWithAppIDRunOnceError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDInvalidLocationAndProximityError  */
    configureSDKWithAppIDInvalidLocationAndProximityError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDSimulatorBlobError  */
    configureSDKWithAppIDSimulatorBlobError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** configureSDKWithAppIDKeyChainInvalidError  */
    configureSDKWithAppIDKeyChainInvalidError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** lastconfigureSDKWithAppIDIndex */
    lastconfigureSDKWithAppIDIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = configureSDKWithAppIDKeyChainInvalidError
};

/**
 requestPIRecommendations errors
 */
typedef NS_ENUM(NSUInteger, requestPIRecommendationsError) {
    /** Initial enum value  */
    firstrequestPIRecommendationsInvalidIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 0,
    /** requestPIRecommendationsNoError  */
    requestPIRecommendationsNoError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = firstrequestPIRecommendationsInvalidIndex,
    /** requestPIRecommendationsInvalidMidParameterError  */
    requestPIRecommendationsInvalidMidParameterError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 1024,
    /** requestPIRecommendationsInvalidRetailerParameterError  */
    requestPIRecommendationsInvalidRetailerParameterError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** requestPIRecommendationsInvalidPageParameterError  */
    requestPIRecommendationsInvalidPageParameterError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** requestPIRecommendationsInvalidCompletionHandlerError  */
    requestPIRecommendationsInvalidCompletionHandlerError DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** lastrequestPIRecommendationsInvalidIndex */
    lastrequestPIRecommendationsInvalidIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = requestPIRecommendationsInvalidCompletionHandlerError
};


/**
 ETEventBus constants
 */

static NSString * const kDidDisplayLocationMessageNotification DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETEventBusDidDisplayLocationMessageNotification";
static NSString * const kDidReceiveGeofenceResponseNotification DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETEventBusDidReceiveGeofenceResponseNotification";
static NSString * const kDidReceiveBeaconResponseNotification DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETEventBusDidReceiveBeaconResponseNotification";
static NSString * const kDidEnterGeofenceNotification DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETEventBusDidEnterGeofenceNotification";
static NSString * const kDidExitGeofenceNotification DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETEventBusDidExitGeofenceNotification";
static NSString * const kDidRangeBeaconNotification DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETEventBusDidRangeBeaconNotification";
static NSString * const kDidReceiveRichMessagesNotification DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETEventBusDidReceiveRichMessagesNotification";
static NSString * const kDidReceiveCloudPagesNotification DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETEventBusDidReceiveRichMessagesNotification";
static NSString * const kDidReceiveLocationUpdateNotification DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = @"ETEventBusDidReceiveLocationUpdateNotification";

/**
 Enumeration of the type of ETMessage this is.
 */
typedef NS_ENUM(NSUInteger, MobilePushMessageType)
{
    /** Initial enum value  */
    firstMobilePushMessageTypeIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 0,
    /** Unknown */
    MobilePushMessageTypeUnknown DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = firstMobilePushMessageTypeIndex,
    /** Basic - A standard push message */
    MobilePushMessageTypeBasic DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** Geofence Entry */
    MobilePushMessageTypeFenceEntry DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 3,
    /** Geofence Exit */
    MobilePushMessageTypeFenceExit DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** Proximity */
    MobilePushMessageTypeProximity DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** lastMobilePushMessageTypeIndex */
    lastMobilePushMessageTypeIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = MobilePushMessageTypeProximity
};

/**
 Enumeration of the type of ETRegion that this is - Circle (Geofence) or Proximity (ibeacon). Polygon is not currently used.
 */
typedef NS_ENUM(NSUInteger, MobilePushGeofenceType) {
    /** Initial enum value  */
    firstMobilePushGeofenceTypeIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 0,
    /** MobilePushGeofenceTypeNone */
    MobilePushGeofenceTypeNone DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = firstMobilePushGeofenceTypeIndex,
    /** MobilePushGeofenceTypeCircle */
    MobilePushGeofenceTypeCircle DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** MobilePushGeofenceTypeProximity */
    MobilePushGeofenceTypeProximity DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 3,
    /** lastMobilePushGeofenceTypeIndex */
    lastMobilePushGeofenceTypeIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = MobilePushGeofenceTypeProximity
};

/**
 Enumeration to keep track of if the request is for Geofences or Proximity messages.
 */
typedef NS_ENUM(NSUInteger, ETRegionRequestType) {
    /** Initial enum value  */
    firstETRegionRequestTypeProximityIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 0,
    /** ETRegionRequestTypeUnknown */
    ETRegionRequestTypeUnknown DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = firstETRegionRequestTypeProximityIndex,
    /** ETRegionRequestTypeGeofence */
    ETRegionRequestTypeGeofence DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** ETRegionRequestTypeProximity */
    ETRegionRequestTypeProximity DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** lastETRegionRequestTypeProximityIndex */
    lastETRegionRequestTypeProximityIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = ETRegionRequestTypeProximity
};

/**
 Bitmask of features that a message has. This is the representation of Push (AlertMessage), Push+Page (AlertMessage + Page), Page Only (Page) in the MobilePush UI.
 */
typedef NS_OPTIONS(NSUInteger, MobilePushContentType) {
    /** Unknown */
    MobilePushContentTypeNone DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 0,
    /** Push Message */
    MobilePushContentTypeAlertMessage DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 1 << 0,
    /** CloudPage */
    MobilePushContentTypePage DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 1 << 1,
    /** Enhanced Cloud Page – Pushed Cloud Pages */
    MobilePushContentTypeEcp DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 1 << 31
};

/**
 Time Unit enumeration for Message limiting.
 */
typedef NS_ENUM(NSUInteger, MobilePushMessageFrequencyUnit) {
    /** Initial enum value  */
    firstMobilePushMessageFrequencyIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = 0,
    /** Unknown */
    MobilePushMessageFrequencyUnitNone DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = firstMobilePushMessageFrequencyIndex,
    /** Year */
    MobilePushMessageFrequencyUnitYear DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** Month */
    MobilePushMessageFrequencyUnitMonth DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** Week */
    MobilePushMessageFrequencyUnitWeek DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** Day */
    MobilePushMessageFrequencyUnitDay DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** Hour */
    MobilePushMessageFrequencyUnitHour DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") ,
    /** lastMobilePushMessageFrequencyIndex */
    lastMobilePushMessageFrequencyIndex DEPRECATED_MSG_ATTRIBUTE("__REPLACEME__") = MobilePushMessageFrequencyUnitHour
};

