package com.example.swiftandroidexample;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.example.swiftandroidexample.adapter.GithubFollowerRecyclerAdapter;
import com.example.swiftandroidexample.model.DataObject;
import com.example.swiftandroidexample.model.GithubFollowerModel;
import com.example.swiftandroidexample.model.GithubUserModel;
import com.example.swiftandroidexample.util.JsonUtils;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;


public class MainActivity extends AppCompatActivity {

    private RecyclerView recyclerView;
    private ProgressBar progressBar;
    private TextView noFollowersTV, followersHeadingTV;

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

        initUIELements();

        // loading dynamic library containing swift code
        System.loadLibrary("SwiftAndroidExample");

        // starting loading of data
        loadData("https://api.github.com/user/followers");
    }

    private void initUIELements() {
        recyclerView = (RecyclerView) findViewById(R.id.recyclerview);
        progressBar = (ProgressBar) findViewById(R.id.progressBar);
        noFollowersTV = (TextView) findViewById(R.id.noFollowersTV);
        followersHeadingTV = (TextView) findViewById(R.id.followers);
    }

    public void onDataLoaded(String data) {
        //tv.setText(data);
        JsonUtils jsonUtils = new JsonUtils();
        // JSONObject jsonObj = jsonUtils.parseStringToJson(data);

        JSONArray jsonArray = jsonUtils.parseStringToJson(data);
        ArrayList<GithubFollowerModel> githubFollowerModels = new ArrayList<>();

        try {
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject currFollowerObject = jsonArray.getJSONObject(i);
                String followerGithubUserID = currFollowerObject.getString("login");
                GithubFollowerModel githubFollowerModel = new GithubFollowerModel(currFollowerObject.getString("avatar_url"), currFollowerObject.getString("login"), currFollowerObject.getString("login"));
                githubFollowerModels.add(githubFollowerModel);
            }
        } catch (JSONException jsonException) {

        }

        // access recyclerview on main thread instance
        Handler mainHandler = new Handler(getMainLooper());
        Runnable myRunnable = new Runnable() {
            @Override
            public void run() {
                followersHeadingTV.setText("Followers: ("+githubFollowerModels.size()+")");
                if (githubFollowerModels.size() == 0) {
                    progressBar.setVisibility(View.GONE);
                    noFollowersTV.setVisibility(View.VISIBLE);
                } else {
                    LinearLayoutManager linearLayoutManager = new LinearLayoutManager(MainActivity.this);
                    recyclerView.setLayoutManager(linearLayoutManager);
                    GithubFollowerRecyclerAdapter githubFollowerRecyclerAdapter = new GithubFollowerRecyclerAdapter(MainActivity.this, githubFollowerModels);
                    recyclerView.setAdapter(githubFollowerRecyclerAdapter);
                    progressBar.setVisibility(View.GONE);
                }
            }
        };
        mainHandler.post(myRunnable);
    }

    private native void loadData(String url);
}