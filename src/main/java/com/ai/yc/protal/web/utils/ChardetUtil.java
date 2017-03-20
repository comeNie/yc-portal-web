package com.ai.yc.protal.web.utils;

import org.mozilla.intl.chardet.nsDetector;
import org.mozilla.intl.chardet.nsICharsetDetectionObserver;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * 用于检测数据流的编码
 * Created by liutong on 2017/3/20.
 */
public class ChardetUtil {
    private nsDetector det;
    private boolean found = false;
    private String result;

    private void initNsDectector() {
        det = new nsDetector();
        det.Init(new nsICharsetDetectionObserver() {
            public void Notify(String charset) {
                found = true;
                result = charset;
            }
        });
    }
    public String detectAllCharset(InputStream in) throws IOException {
        initNsDectector();
        String prob;
        BufferedInputStream imp = new BufferedInputStream(in);
        byte[] buf = new byte[1024];
        int len;
        boolean isAscii = true;
        while ((len = imp.read(buf, 0, buf.length)) != -1) {
            // Check if the stream is only ascii.
            if (isAscii)
                isAscii = det.isAscii(buf, len);
            // DoIt if non-ascii and not done yet.
            if (!isAscii && det.DoIt(buf, len, false)){
                break;
            }
        }
        imp.close();
        in.close();
        det.DataEnd();
        if (isAscii) {
            found = true;
            prob = "ASCII";
        } else if (found) {
            prob = result;
        } else {
            prob = det.getProbableCharsets()[0];
        }
        return prob;
    }


}
