package com.example.swiftandroidexample.adapter;

import android.content.Context;
import android.net.Uri;
import android.view.ContentInfo;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.swiftandroidexample.R;
import com.example.swiftandroidexample.model.GithubFollowerModel;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;

public class GithubFollowerRecyclerAdapter extends RecyclerView.Adapter<GithubFollowerViewHolder> {

    private Context context;
    private ArrayList<GithubFollowerModel> githubFollowerModels;

    public GithubFollowerRecyclerAdapter(Context context, ArrayList<GithubFollowerModel> githubFollowerModels) {
        this.context = context;
        this.githubFollowerModels = githubFollowerModels;
    }

    @NonNull
    @Override
    public GithubFollowerViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view =  LayoutInflater.from(context).inflate(R.layout.follower_recycler_item, parent, false);
        return new GithubFollowerViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull GithubFollowerViewHolder holder, int position) {
        GithubFollowerModel currGithubFollower = githubFollowerModels.get(position);
        holder.githubUserNameTV.setText(currGithubFollower.getUserName());

        // load the github profile image of follower
        if(currGithubFollower.getImageUrl() != null) {
            Picasso.get().load(Uri.parse(currGithubFollower.getImageUrl())).into(holder.githubUserImageIV);
        }
    }

    @Override
    public int getItemCount() {
        return githubFollowerModels.size();
    }
}

class GithubFollowerViewHolder extends RecyclerView.ViewHolder {
    TextView githubUserNameTV;
    ImageView githubUserImageIV;

    public GithubFollowerViewHolder(@NonNull View itemView) {
        super(itemView);
        githubUserNameTV = (TextView) itemView.findViewById(R.id.githubUserNameTV);
        githubUserImageIV = (ImageView) itemView.findViewById(R.id.imageFollowerIV);
    }
}
