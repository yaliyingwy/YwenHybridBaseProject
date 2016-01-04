package ywen.com.hybridandroid.hello;

import android.os.Bundle;
import android.support.annotation.Nullable;

public class HelloLoginFramgment extends HybridFragment {
    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.setHtmlPage("hello-login.html");
    }
}
