package com.example.arm0nius.accessmartremote;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothGattCallback;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothManager;
import android.bluetooth.BluetoothProfile;
import android.content.Intent;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.SeekBar;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class seekBar extends AppCompatActivity {

    private String adress;

    private ProgressBar attente;
    private SeekBar vitesse;
    private Button coDeco;

    private BluetoothGatt mGatt;
    private BluetoothGattCharacteristic characteristic;
    private BluetoothGattService service;

    private List<BluetoothGattService> services = new ArrayList<>();



    private Handler handler = new Handler();



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        adress = getIntent().getStringExtra(MainActivity.EXTRA_ADDRESS);

        setContentView(R.layout.activity_seek_bar);

        attente = (ProgressBar)findViewById(R.id.progressCircle);





        connection();

        vitesse = (SeekBar)findViewById(R.id.vitesse);
        vitesse.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                int entierEnvoyer = progress*progress/seekBar.getMax();
                System.out.println(entierEnvoyer);
                String texte = Integer.toString(entierEnvoyer);
                characteristic.setValue(texte + "\n");
                boolean succesStringWrite = mGatt.writeCharacteristic(characteristic);
                System.out.println("String test " + succesStringWrite);
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                seekBar.setProgress(1000);
            }
        });

        coDeco = (Button)findViewById(R.id.connection);
        final Activity courante = this;
        coDeco.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mGatt.disconnect();
                courante.finish();
            }
        });





    }

    public void connection() {

        new Thread(new Runnable() {
            @Override
            public void run() {
                final BluetoothManager bluetoothManager = (BluetoothManager) getSystemService(BLUETOOTH_SERVICE);
                BluetoothAdapter adapter = bluetoothManager.getAdapter();
                final BluetoothDevice device = adapter.getRemoteDevice(adress);
                BLEWatcher bleWatcher = new BLEWatcher();
                mGatt = device.connectGatt(seekBar.this, false, bleWatcher);

                do {
                    try {
                        Thread.sleep(50);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    System.out.println("etat de connection " + mGatt.connect());
                } while (!mGatt.connect());

                boolean findCharacteristic;

                do {
                    mGatt.discoverServices();
                    findCharacteristic = bleWatcher.isFindCharacteristic();
                    try {
                        Thread.sleep(250);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                } while (!findCharacteristic);

                characteristic = bleWatcher.getCharacteristic();


                handler.post(new Runnable() {
                    @Override
                    public void run() {
                        attente.setVisibility(View.GONE);
                        vitesse.setVisibility(View.VISIBLE);
                        coDeco.setVisibility(View.VISIBLE);
                        Toast.makeText(getApplicationContext(),"Vous êtes connectés", Toast.LENGTH_LONG).show();
                    }
                });

            }
        }).start();

    }
}

