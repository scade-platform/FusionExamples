package com.example.swiftandroidexample.model;

import java.io.Serializable;

public class GithubFollowerModel implements Serializable {
    private String imageUrl;
    private String userName;

    public GithubFollowerModel(String imageUrl, String userName, String userID) {
        this.imageUrl = imageUrl;
        this.userName = userName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
