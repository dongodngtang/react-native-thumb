import {NativeModules} from 'react-native';

const {RNReactNativeThumb} = NativeModules;

export default class Thumb {

    static getVideoCover(path) {
        RNReactNativeThumb.getVideoCover(path)
    }
}


