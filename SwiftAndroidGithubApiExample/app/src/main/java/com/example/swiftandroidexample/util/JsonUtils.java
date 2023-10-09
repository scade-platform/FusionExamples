package com.example.swiftandroidexample.util;

import android.content.Context;
import android.os.Environment;
import android.util.Log;

import com.example.swiftandroidexample.model.DataObject;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;


public class JsonUtils {
     public JSONArray parseStringToJson(String str)  {

        try {
            JSONArray jsonArray = new JSONArray(str);

            return jsonArray;
        }catch (Exception err){
            Log.d("Error", err.toString());
        }




        return null;
    }

}


