package com.example.swiftandroidexample.model;

import java.util.ArrayList;
import java.util.List;

public class DataObject {
    private List<GithubUserModel> githubUserModels;

    public DataObject(ArrayList<GithubUserModel> githubUserModels) {
        this.githubUserModels = githubUserModels;
    }

    public List<GithubUserModel> getGithubUserModels() {
        return githubUserModels;
    }

    public void setGithubUserModels(List<GithubUserModel> githubUserModels) {
        this.githubUserModels = githubUserModels;
    }
}
