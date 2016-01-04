package ywen.com.hybridandroid.hello;

import android.os.Bundle;
import android.support.annotation.Nullable;

/**
 * Created by ywen(yaliyingwy@gmail.com) on 16/1/1.
 */
public class HelloItemListFragment extends HybridFragment {
    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.setHtmlPage("hello-items.html");
    }
}
