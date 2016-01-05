package ywen.com.hybridandroid.hello;


import android.os.Build;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import ywen.com.hybrid.HybridCore;
import ywen.com.hybrid.HybridNav;
import ywen.com.hybrid.HybridUI;
import ywen.com.hybrid.HybridUIImpl;
import ywen.com.hybrid.HybridWebView;
import ywen.com.hybrid.HybridWebViewImpl;
import ywen.com.hybridandroid.R;

/**
 * A simple {@link Fragment} subclass.
 */
public class HybridFragment extends Fragment implements HybridCore{

    private HybridWebView webView;
    private String htmlPage = null;

    private HybridUI hybridUI = new HybridUIImpl();

    public HybridNav getHybridNav() {
        return hybridNav;
    }

    public void setHybridNav(HybridNav hybridNav) {
        this.hybridNav = hybridNav;
    }

    public HybridUI getHybridUI() {
        return hybridUI;
    }

    public void setHybridUI(HybridUI hybridUI) {
        this.hybridUI = hybridUI;
    }

    private HybridNav hybridNav = null;

    public HybridWebView getWebView() {
        return webView;
    }

    public void setWebView(HybridWebView webView) {
        this.webView = webView;
    }

    public String getHtmlPage() {
        return htmlPage;
    }

    public void setHtmlPage(String htmlPage) {
        this.htmlPage = htmlPage;
    }

    public HybridFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_hybrid, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        webView = (HybridWebViewImpl) view.findViewById(R.id.hybrid_webview);
        if (htmlPage != null) {
            webView.loadPage(this, htmlPage);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
                ((WebView)webView).getSettings().setAllowUniversalAccessFromFileURLs(true);
            }

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                WebView.setWebContentsDebuggingEnabled(true);
            }
            // FIXME: 16/1/5 替换成真的数据
            ((WebView)webView).loadUrl("javascript:(function(){window.uuid=1;window.client_type='1';window.version='1'})()");
        }
    }


    @Override
    public void callFromjs(HybridWebView webView, String tag, JSONObject params, String callback) {
        if ("push".equals(tag)) {
            this.hybridNav.push(webView, params, callback);
            this.success(webView, callback, null);
        }
        else if ("toast".equals(tag))
        {
            this.hybridUI.toast(this.getActivity(), params);
        }
        else if ("loading".equals(tag))
        {
            this.hybridUI.loading(this.getActivity(), params);
        }
        else if ("alert".equals(tag))
        {
            this.hybridUI.alert(this.getActivity(), webView, params, callback);
        }
        else
        {
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("msg", "例子里面还没实现呢！");
            webView.callJs(paramMap);
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("msg", "VIEW_APPEAR");
        webView.callJs(paramMap);
    }

    @Override
    public void success(HybridWebView webView, String callback, Map params) {
        webView.success(callback, params);
    }

    @Override
    public void error(HybridWebView webView, String callback, String error) {
        webView.error(callback, error);

    }
}
