# FirCodable

A Extension of Firebase Realtime Database for use Codable on ref observer.

## Current Version

version 1.0.1

## install

Firebase Codable can be install only with spm. Add this line to your Package.swift file
```swift
 .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "8.5.0"),
```

## How to use 

 * you can use `DataSnapshotDecoder` to transform Datasnapshot to class or struct conform to Codable protocol and use `DataSnapshotEncoder` to transform class or struct conform to Codable protocol to Dictionary.

 * use function on `DatabaseReference` for listen all change:
    ```swift 
        func observe<C: Codable>(_ type: DataEventType, completion: @escaping(_ value: C?, _ error: Error?) -> Void)

        func observeSingleEvent<C: Codable>(_ type: DataEventType, completion: @escaping(_ value: C?, _ error: Error?) -> Void)
    ```






