package ywen.com.hybridandroid.hello;

import android.os.Bundle;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.ActionBarActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;

import org.json.JSONObject;

import ywen.com.hybrid.HybridNav;
import ywen.com.hybrid.HybridWebView;
import ywen.com.hybridandroid.R;


public class HelloActivity extends ActionBarActivity implements HybridNav, View.OnClickListener {

    private HelloLoginFramgment loginFramgment;
    private HelloItemListFragment itemListFragment;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hello);

        this.findViewById(R.id.rl_login).setOnClickListener(this);
        this.findViewById(R.id.rl_items).setOnClickListener(this);

        loginFramgment = new HelloLoginFramgment();

        itemListFragment = new HelloItemListFragment();

        showIndex(0);

    }


    public void showIndex(int index) {
        FragmentManager fragmentManager = getSupportFragmentManager();
        fragmentManager.popBackStack();
        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        if (index == 0) {
            fragmentTransaction.replace(R.id.tabcontent, loginFramgment);
        }
        else if (index == 1)
        {
            fragmentTransaction.replace(R.id.tabcontent, itemListFragment);
        }
        fragmentTransaction.commit();
    }





    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_hello, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }


    @Override
    public void popTo(int index) {

    }

    @Override
    public void push(HybridWebView webView, JSONObject params, String callback) {

    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.rl_login:
                showIndex(0);
                break;
            case R.id.rl_items:
                showIndex(1);
                break;
        }
    }
}
