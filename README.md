# react-native-thumb
根据视频文件获取缩略图-取第一帧

# react-native-react-native-thumb

## Getting started

`$ npm install react-native-react-native-thumb --save`

### Mostly automatic installation

`$ react-native link react-native-react-native-thumb`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-react-native-thumb` and add `RNReactNativeThumb.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNReactNativeThumb.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNReactNativeThumbPackage;` to the imports at the top of the file
  - Add `new RNReactNativeThumbPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-react-native-thumb'
  	project(':react-native-react-native-thumb').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-react-native-thumb/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-react-native-thumb')
  	```


## Usage
```javascript
import RNReactNativeThumb from 'react-native-react-native-thumb';

// TODO: What to do with the module?
RNReactNativeThumb;
```
  


