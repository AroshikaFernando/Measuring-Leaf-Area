package com.example.lah.leafarea;

import android.app.Activity;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

/**
 * Created by La$h on 12/13/2016.
 */

public class Display extends Activity{


    TextView intro,intro1,intro2,intro3,intro4;


        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.display);


            intro = (TextView) findViewById(R.id.intro);
            intro1 = (TextView) findViewById(R.id.intro1);
            intro2 = (TextView) findViewById(R.id.intro2);
            intro3 = (TextView) findViewById(R.id.intro3);
            intro4 = (TextView) findViewById(R.id.intro4);

        }


}
