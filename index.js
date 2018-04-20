import {NativeModules} from 'react-native';

const {RNReactNativeThumb} = NativeModules;

export default class Thumb {

    static getVideoCover(path, callback) {
        RNReactNativeThumb.getVideoCover(path, callback)
    }
}




