package com.example.swiftandroidexample;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.button.MaterialButton;
import com.google.android.material.textfield.TextInputEditText;


public class MainActivity extends AppCompatActivity {
    // declare ui widgets variables
    private TextView validationResultTV;
    private TextInputEditText passwordET, confirmPasswordET;
    private MaterialButton validateButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        try {
            // initializing swift runtime.
            // The first argument is a pointer to java context (activity in this case).
            // The second argument should always be false.
            org.swift.swiftfoundation.SwiftFoundation.Initialize(this, false);
        } catch (Exception err) {
            android.util.Log.e("SwiftAndroidExample", "Can't initialize swift foundation: " + err.toString());
        }

        // loading dynamic library containing swift code
        System.loadLibrary("SwiftAndroidExample");

        initUIWidgets();

        validateButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String passwordString = passwordET.getText().toString().trim();
                String confirmPasswordString = confirmPasswordET.getText().toString().trim();
                if (TextUtils.isEmpty(passwordString) || TextUtils.isEmpty(confirmPasswordString)) {
                    Toast.makeText(getApplicationContext(), "One or more fields are empty!", Toast.LENGTH_SHORT).show();
                    return;
                }
                // starting validation of password
                validatePassword(passwordString, confirmPasswordString);
            }
        });
    }

    private void initUIWidgets() {
        validationResultTV = (TextView) findViewById(R.id.validationResultTV);
        passwordET = (TextInputEditText) findViewById(R.id.passwordET);
        confirmPasswordET = (TextInputEditText) findViewById(R.id.confirmPasswordET);
        validateButton = (MaterialButton) findViewById(R.id.validatePasswordBtn);
    }

    // method is called from swift code, and result is sent as input parameter
    public void onPasswordValidated(String validationResult) {
        validationResultTV.setText(validationResult);
    }

    // custom method to be called from java
    // implementation of method is in Swift file
    private native void validatePassword(String passwordString,
                                         String confirmPasswordString);
}