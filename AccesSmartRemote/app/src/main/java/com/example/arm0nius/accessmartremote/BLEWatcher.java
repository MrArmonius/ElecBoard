package com.example.arm0nius.accessmartremote;

import android.bluetooth.BluetoothGatt;
import android.bluetooth.BluetoothGattCallback;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothProfile;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Bibliothèque pour observer les
 * devices Bluetooth Low Energy sans filtres
 */

public class BLEWatcher extends BluetoothGattCallback {


    public boolean isFindCharacteristic() {
        return findCharacteristic;
    }

    private boolean findCharacteristic = false;

    public BluetoothGattCharacteristic getCharacteristic() {
        return characteristic;
    }

    private BluetoothGattCharacteristic characteristic;
    private List<BluetoothGattService> services = new ArrayList<>();

    public BLEWatcher() {

    }

    private UUID SERVICE_UUID = UUID.fromString("0000FFE0-0000-1000-8000-00805F9B34FB");
    private UUID CHARACTERISTIC_UUID = UUID.fromString("0000FFE1-0000-1000-8000-00805F9B34FB");

    @Override
    public void onConnectionStateChange(BluetoothGatt gatt, int status, int newState) {
        super.onConnectionStateChange(gatt, status, newState);
        System.out.println("changement d'etat de connection effectue " + status);
        if(newState == BluetoothProfile.STATE_CONNECTED){
            System.out.println("connecte");


        }
        else if (newState == BluetoothProfile.STATE_DISCONNECTED){
            System.out.println("deconnecté");

        }
    }

    @Override
    public void onServicesDiscovered(BluetoothGatt gatt, int status) {
        super.onServicesDiscovered(gatt, status);
        System.out.println("Status de system discovered :" + status);
        services = gatt.getServices();
        for(BluetoothGattService service : services){
            if(service.getUuid().equals(SERVICE_UUID)) {
                characteristic = service.getCharacteristic(CHARACTERISTIC_UUID);
                System.out.println("On a trouvé notre characteristic");
                findCharacteristic = true;
                return;
            }
        }
    }

    @Override
    public void onCharacteristicRead(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic, int status) {
        super.onCharacteristicRead(gatt, characteristic, status);
    }

    @Override
    public void onCharacteristicWrite(BluetoothGatt gatt, BluetoothGattCharacteristic characteristic, int status) {
        super.onCharacteristicWrite(gatt, characteristic, status);
    }

}
