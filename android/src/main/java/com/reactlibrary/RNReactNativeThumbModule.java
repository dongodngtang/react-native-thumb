
package com.reactlibrary;

import android.graphics.Bitmap;
import android.media.MediaMetadataRetriever;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class RNReactNativeThumbModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public RNReactNativeThumbModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "RNReactNativeThumb";
    }

    @ReactMethod
    public void getVideoCover(String videoPath,Callback callback) {
        try {
            MediaMetadataRetriever retriever = new MediaMetadataRetriever();
//获取网络视频
//    retriever.setDataSource(url, new HashMap<String, String>());
//获取本地视频

            retriever.setDataSource(videoPath);
            Bitmap bitmap = retriever.getFrameAtTime();
            FileOutputStream outStream = null;
            final String localThumb = reactContext.getExternalCacheDir().getAbsolutePath() + "/" + System.currentTimeMillis() + ".jpg";
            outStream = new FileOutputStream(new File(localThumb));
            bitmap.compress(Bitmap.CompressFormat.JPEG, 70, outStream);
            outStream.close();
            retriever.release();
            callback.invoke(new Object(){
                private String image_path = localThumb;
            });
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception err) {
            err.printStackTrace();
        }
    }
}