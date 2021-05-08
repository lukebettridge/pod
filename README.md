[<img src="https://is5-ssl.mzstatic.com/image/thumb/Purple124/v4/ca/48/ac/ca48acdb-2d41-aec3-6453-cccab13b40f3/AppIcon-0-1x_U007emarketing-0-0-0-7-0-0-85-220.png/1200x630wa.png" />](https://apps.apple.com/us/app/pod-coffee-capsules/id1547170152)

# Pod: Coffee Capsules

Pod offers detailed information about the entire range of Nespresso coffee capsules. Organise your own collection of capsules within the app, stored safely in iCloud. Automatically record your water and caffeine consumption in the Health app.

[<img src="https://developer.apple.com/app-store/marketing/guidelines/images/badge-download-on-the-app-store.svg" height="45" />](https://apps.apple.com/us/app/pod-coffee-capsules/id1547170152)

## Implementation

### UI

The user interface is built almost entirely using SwiftUI with the UIKit App Delegate to manage its life cycle.

### Firebase

The app relies on a Firebase Cloud Firestore Database which stores the capsule information. Firestore offers offline support, caching the majority of the dataset on-device.

Google Cloud Storage is used to store assets such as capsule images and Firestore backups. Firestore capsule entries reference the relevant object keys for related assets. These assets are also stored on-device.

Firebase Cloud Functions are used to collate analytical data captured by Google Analytics. This allows Pod to display the most popular and most favourited capsules back to the user. These functions are run daily, making SQL queries to BigQuery, and storing the collated data as Firebase Remote Config parameters. The repository for these Cloud Functions can be found here: [lukebettridge/pod-functions](https://github.com/lukebettridge/pod-functions).

### Data

The capsule information itself is collected manually via the Firestore UI or a self-built form within a small Next.js application behind Firebase SMS Authentication. The repository for this can be found here: [lukebettridge/pod-web](https://github.com/lukebettridge/pod-web).

## Screenshots

Collection|Capsule|Search|Explore|Trends
-|-|-|-|-
<img src="https://is5-ssl.mzstatic.com/image/thumb/PurpleSource124/v4/51/b4/24/51b4246e-a288-4722-8000-270a1fc0458b/721c55f3-423c-4009-b873-2180f0efa3fa_screen-1.jpg/460x0w.jpg" />|<img src="https://is4-ssl.mzstatic.com/image/thumb/PurpleSource114/v4/a1/e8/ee/a1e8ee36-c822-1368-3e76-96a8f66aebec/ff3293cd-5095-4664-9fbd-dbf8b4503b22_screen-2.jpg/460x0w.jpg" />|<img src="https://is3-ssl.mzstatic.com/image/thumb/PurpleSource114/v4/64/c3/d5/64c3d5c7-e6d2-2e00-b328-2204873b638d/62a54f24-2100-4da0-b9fe-f12bb591e222_screen-4.jpg/460x0w.jpg" />|<img src="https://is4-ssl.mzstatic.com/image/thumb/PurpleSource124/v4/73/b1/43/73b14334-51e5-c8d6-9443-dea749b10f43/4c96169a-1283-4c86-9996-17260859a01e_screen-9.jpg/460x0w.jpg" />|<img src="https://is1-ssl.mzstatic.com/image/thumb/PurpleSource124/v4/c9/21/81/c92181d5-d960-692c-0085-d11f50f1084d/d5cbfc5b-14f0-4ec6-89bd-71a6ab3bfab1_screen-6.jpg/460x0w.jpg" />
