package ywen.com.hybridandroid.hello;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import org.json.JSONException;
import org.json.JSONObject;

import ywen.com.hybrid.HybridNav;
import ywen.com.hybrid.HybridWebView;

public class HelloLoginFramgment extends HybridFragment implements HybridNav {
    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.setHtmlPage("hello-login.html");
        this.setHybridNav(this);

    }

    @Override
    public void popTo(int index) {

    }

    @Override
    public void push(HybridWebView webView, JSONObject params, String callback) {
        try {
            String page = params.getString("page");
            switch (page) {
                case "/hello-demo.html":
                    startActivity(new Intent(getActivity(), HelloDemoActivity.class));
                    break;
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}
