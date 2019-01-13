package com.example.arm0nius.accessmartremote;

import android.Manifest;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Handler;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

import no.nordicsemi.android.support.v18.scanner.BluetoothLeScannerCompat;
import no.nordicsemi.android.support.v18.scanner.ScanCallback;
import no.nordicsemi.android.support.v18.scanner.ScanResult;

public class MainActivity extends AppCompatActivity {

    private int SCAN_PERIOD = 10000;
    public static String EXTRA_ADDRESS = "device_address";

    private Button scan;
    private ListView blueList;
    private ArrayAdapter<String> arrayAdapter;

    private BluetoothAdapter myBlue;
    private BluetoothLeScannerCompat scanner;
    private Handler mHandler;

    private ArrayList<BluetoothDevice> BLEresults = new ArrayList<>();
    private ArrayList<String> BLEaffiche = new ArrayList<>();

    private final Runnable mStopScan = new Runnable() {
        @Override
        public void run() {
            Toast.makeText(getApplicationContext(),"Aucun device trouvé", Toast.LENGTH_SHORT).show();
            System.out.println("scan fini BLE");
            scanner.stopScan(mScanCallback);
        }
    };


    private final ScanCallback mScanCallback = new ScanCallback() {
        @Override
        public void onScanResult(int callbackType, ScanResult result) {
            // super.onScanResult(callbackType, result);
            System.out.println("Méthode avec 0delay");
            System.out.println("Device find: " + result.getDevice().getName());
            if(!BLEresults.contains(result.getDevice())){
                BLEresults.add(result.getDevice());
                BLEaffiche.add("Nom: " + result.getDevice().getName() + "\nAdresse: " + result.getDevice().getAddress());
                arrayAdapter.notifyDataSetChanged();
            }

            // We scan with report delay > 0. This will never be called.
        }

        @Override
        public void onBatchScanResults(List<ScanResult> results) {
            System.out.println("Method 2");
            for(ScanResult result : results){
                BLEresults.add(result.getDevice());
                System.out.println("Device find: " + result.getDevice().getName());
            }
        }

        @Override
        public void onScanFailed(int errorCode) {
            super.onScanFailed(errorCode);
            Toast.makeText(getApplicationContext(),"Une erreur est arrivée" + errorCode, Toast.LENGTH_SHORT).show();
        }
    };


    // ECRIT PAR QUENTIN, A REECRIRE SI POSSIBLE
    static final int PERMISSION_ALL = 1;
    private final String[] PERMISSIONS = {Manifest.permission.ACCESS_COARSE_LOCATION};

    public static boolean hasPermission(Context context, String... permissions) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && context != null && permissions != null) {
            for (String permission : permissions) {
                if (ActivityCompat.checkSelfPermission(context, permission) != PackageManager.PERMISSION_GRANTED) {
                    return false;
                }

            }
        }
        return true;
    }

    protected void runtimePermission() {
        if (!hasPermission(MainActivity.this, PERMISSIONS)) {
            ActivityCompat.requestPermissions(this, PERMISSIONS, PERMISSION_ALL);
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode) {
            case PERMISSION_ALL:
                if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    System.out.println("YEAAAH on a eu notre permission !");

                }
                else {
                    Toast.makeText(this, "Permission Denied", Toast.LENGTH_SHORT).show();
                }
                break;
        }
    }

    // FIN REECRITURE QUENTIN

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);



        BluetoothManager bluetoothManager = (BluetoothManager) getSystemService(BLUETOOTH_SERVICE);
        myBlue = bluetoothManager.getAdapter();


        if(myBlue == null){
            Toast.makeText(getApplicationContext(), "Bluetooth Device Not Available", Toast.LENGTH_LONG).show();
            finish();
        }
        else{
            if(myBlue.isEnabled()){
                Toast.makeText(getApplicationContext(), "Bluetooth Activate Merci", Toast.LENGTH_LONG).show();
            }
            else{
                Intent turnBTon = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                startActivityForResult(turnBTon,1);
            }
        }

        scan = (Button)findViewById(R.id.show);



        scanner = BluetoothLeScannerCompat.getScanner();
        //settings = new ScanSettings.Builder()
        //        .setScanMode(ScanSettings.SCAN_MODE_LOW_POWER)
        //        .setReportDelay(1000)
        //        .build();
        //scanFilter = new ScanFilter.Builder()
        //        .setServiceUuid(ParcelUuid.fromString("0xFFE")).build();

        scan.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                runtimePermission();
                System.out.println("J'ai commencé le scan");
                scanner.startScan(mScanCallback);
                mHandler = new Handler();
                mHandler.postDelayed(mStopScan, SCAN_PERIOD);
            }
        });

        blueList = (ListView)findViewById(R.id.devicesList);
        blueList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                mHandler.removeCallbacks(mStopScan);
                scanner.stopScan(mScanCallback);
                //Toast.makeText(getApplicationContext(),"Vous avez selectionné: " + BLEresults.get(position).getName(), Toast.LENGTH_SHORT).show();
                Intent newintent = new Intent(MainActivity.this, seekBar.class);
                newintent.putExtra(EXTRA_ADDRESS, BLEresults.get(position).getAddress());
                startActivity(newintent);
            }
        });


        arrayAdapter= new ArrayAdapter<>(MainActivity.this,
                android.R.layout.simple_list_item_1, BLEaffiche);
        blueList.setAdapter(arrayAdapter);
    }

}
