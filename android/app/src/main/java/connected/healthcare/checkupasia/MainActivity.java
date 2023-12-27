package connected.healthcare.checkupasia;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

import com.ideabus.model.bluetooth.MyBluetoothLE;
import com.ideabus.model.data.CurrentAndMData;
import com.ideabus.model.data.DRecord;
import com.ideabus.model.data.DeviceInfo;
import com.ideabus.model.data.User;
import com.ideabus.model.data.VersionData;
import com.ideabus.model.protocol.BPMProtocol;
import com.ideabus.model.protocol.Global;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MainActivity extends FlutterActivity implements BPMProtocol.OnConnectStateListener, BPMProtocol.OnDataResponseListener, BPMProtocol.OnNotifyStateListener, MyBluetoothLE.OnWriteStateListener {


    private static final String CHANNEL = "testingJavaCode";
    private static final String bloodchannel = "Blood_Presure";
    private static final String getstoredrecored = "GetStoredRrecored";
    private BPMProtocol bpmProtocol; // Declare bpmProtocol
    private static DRecord storedDRecord;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Global.bpmProtocol = BPMProtocol.getInstance(this, false, true, "LsdEqFZas!5zF2%m");
        Global.bpmProtocol.addDeviceName(BPMProtocol.DeviceType.DEVICE_TYPE_BPM_4G,"6024N");
        Global.bpmProtocol.setOnConnectStateListener(this);
        Global.bpmProtocol.setOnDataResponseListener(this);
        Global.bpmProtocol.setOnNotifyStateListener(this);
        Global.bpmProtocol.setOnWriteStateListener(this);




    }

//    @Override
//    protected void onStart() {
//
//        super.onStart();
//
//
//    }







    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
//


        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), bloodchannel)
                .setMethodCallHandler(new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        if (call.method.equals("ReadData")) {
                            if (Global.bpmProtocol != null) {
                                Log.d("ProtocolValue", "Global BPM Protocol: " + Global.bpmProtocol);

                                Global.bpmProtocol.bond("DE:81:80:59:C0:6A");
                                connect("DE:81:80:59:C0:6A");


                                Global.bpmProtocol.readHistorysOrCurrDataAndSyncTiming();
                                Global.bpmProtocol.readLastData();


//                              int data= 66;
                                result.success(null);
                            } else {
                                Log.d("ProtocolValue", "Global BPM Protocol: " + Global.bpmProtocol);
                                // Handle bpmProtocol not being initialized
                                result.error("UNAVAILABLE", "BPMProtocol not initialized", null);
                            }
                        }
                    }


                });
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), getstoredrecored)
                .setMethodCallHandler(new MethodCallHandler() {
                                          @Override
                                          public void onMethodCall(MethodCall call, Result result) {
                                              if (call.method.equals("getStoredDRecord")) {
                                                  if (Global.bpmProtocol != null) {
                                                      Log.d("ProtocolValue", "Global BPM Protocol: " + Global.bpmProtocol);

                                                      getStoredDRecord();
                                                      DRecord drecoredstored = getStoredDRecord();
                                                      List<CurrentAndMData> mData = drecoredstored.getMData();
                                                      List<Map<String, Object>> mDataList = new ArrayList<>();
                                                      List<Map<String, Object>> lastdata = null;
                                                      for (CurrentAndMData data : mData) {
                                                          Map<String, Object> map = new HashMap<>();
                                                          // Extract properties from CurrentAndMData and put them in the map
                                                          map.put("systole", data.getSystole());
                                                          map.put("dia", data.getDia());
                                                          map.put("pul", data.getHr());
                                                          // Add more properties as needed

                                                          mDataList.add(map);
                                                          lastdata = new ArrayList<>();
                                                          if (!mDataList.isEmpty()) {
                                                              lastdata.add(mDataList.get(mDataList.size() - 1));
                                                          }
                                                      }

                                                      Log.d("ProtocolValue", "drecoredstorednewwwwwww: " + lastdata);


//                              int data= 44;
                                                      result.success(lastdata);
                                                  }
                                                  else {
                                                      Log.d("ProtocolValue", "Global BPM Protocol: " + Global.bpmProtocol);
                                                      // Handle bpmProtocol not being initialized
                                                      result.error("UNAVAILABLE", "BPMProtocol not initialized", null);
                                                  }
                                              }
                                          }



                                      }

                );
    }




    public void connect(String mac){
        Global.bpmProtocol.connect(mac);
    }


    @Override
    public void onWriteMessage(boolean b, String s) {

    }

    @Override
    public void onBtStateChanged(boolean b) {

    }

    @Override
    public void onScanResult(String s, String s1, int i, BPMProtocol.DeviceType deviceType) {

    }

    @Override
    public void onConnectionState(BPMProtocol.ConnectState connectState) {

    }

    @Override
    public void onResponseReadHistory(DRecord dRecord) {

        Log.d("ProtocolValue", "currentdata: " +dRecord);
        storedDRecord=dRecord;


    }
    public static DRecord getStoredDRecord() {
        return storedDRecord;
    }


    @Override
    public void onResponseClearHistory(boolean b) {
        Log.d("ProtocolValue", "currentdata: deeeeeleeete " );
    }

    @Override
    public void onResponseReadUserAndVersionData(User user, VersionData versionData) {

    }

    @Override
    public void onResponseWriteUser(boolean b) {

    }

    @Override
    public void onResponseReadLastData(CurrentAndMData currentAndMData, int i, int i1, int i2, boolean b) {
        Log.d("ProtocolValue", "currentdata: " +currentAndMData);

    }

    @Override
    public void onResponseClearLastData(boolean b) {

    }

    @Override
    public void onResponseReadDeviceInfo(DeviceInfo deviceInfo) {

    }

    @Override
    public void onResponseReadDeviceTime(DeviceInfo deviceInfo) {

    }

    @Override
    public void onResponseWriteDeviceTime(boolean b) {

    }

    @Override
    public void onNotifyMessage(String s) {

    }}


//    @Override
//    public void onBtStateChanged(boolean b) {
//
//    }
//
//    @Override
//    public void onScanResult(String s, String s1, int i, BPMProtocol.DeviceType deviceType) {
//
//    }
//
//    @Override
//    public void onConnectionState(BPMProtocol.ConnectState connectState) {
//
//    }
//
//    @Override
//    public void onResponseReadHistory(DRecord dRecord) {
//       dRecord.getCurrentData();
//
//    }
//
//    @Override
//    public void onResponseClearHistory(boolean b) {
//
//    }
//
//    @Override
//    public void onResponseReadUserAndVersionData(User user, VersionData versionData) {
//
//    }
//
//    @Override
//    public void onResponseWriteUser(boolean b) {
//
//    }
//
//    @Override
//    public void onResponseReadLastData(CurrentAndMData currentAndMData, int i, int i1, int i2, boolean b) {
//        bpmProtocol.readLastData();
//currentAndMData.getSystole();
//currentAndMData.getDia();
//currentAndMData.getPVR();
//    }
//
//    @Override
//    public void onResponseClearLastData(boolean b) {
//
//    }
//
//    @Override
//    public void onResponseReadDeviceInfo(DeviceInfo deviceInfo) {
//
//    }
//
//    @Override
//    public void onResponseReadDeviceTime(DeviceInfo deviceInfo) {
//
//    }
//
//    @Override
//    public void onResponseWriteDeviceTime(boolean b) {
//
//    }
//
//    @Override
//    public void onNotifyMessage(String s) {
//
//    }
//
//    @Override
//    public void onWriteMessage(boolean b, String s) {
//
//    }




//  @Override
//  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//
//
//    super.configureFlutterEngine(flutterEngine);
//
//    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//            .setMethodCallHandler(new MethodCallHandler() {
//
//              @Override
//              public void onMethodCall(MethodCall call, Result result) {
//                if (call.method.equals("getBatteryLevel")) {
//                  int batteryLevel = getBatteryLevel();
//
//                  if (batteryLevel != -1) {
//                    result.success(batteryLevel);
//                  } else {
//                    result.error("UNAVAILABLE", "Battery level not available.", null);
//                  }
//                } else {
//                  result.notImplemented();
//                }
//              }
//            });
//  }
//
//  private int getBatteryLevel() {
//    IntentFilter ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
//    Intent batteryStatus = registerReceiver(null, ifilter);
//
//    if (batteryStatus != null) {
//      int level = batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
//      int scale = batteryStatus.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
//
//      if (level != -1 && scale != -1) {
//        return (int) ((level / (float) scale) * 100);
//      }
//    }
//    return -1;
//  }
//
//
//
//}




















//  private static final String CHANNEL = "testingJavaCode";
//
//
//
//  @Override
//  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//  super.configureFlutterEngine(flutterEngine);
//    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//        .setMethodCallHandler(
//          (call, result) -> {
//            // This method is invoked on the main thread.
//            if (call.method.equals("getBatteryLevel")) {
//              int batteryLevel = getBatteryLevel();
//
//              if (batteryLevel != -1) {
//                result.success(batteryLevel);
//              } else {
//                result.error("UNAVAILABLE", "Battery level not available.", null);
//              }
//            } else {
//              result.notImplemented();
//            }
//          }
//        );
//  }
//
//    private int getBatteryLevel() {
//    int batteryLevel = -1;
//    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
//      BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
//      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
//    } else {
//      Intent intent = new ContextWrapper(getApplicationContext()).
//          registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
//      batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
//          intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
//    }
//
//    return batteryLevel;
//  }


