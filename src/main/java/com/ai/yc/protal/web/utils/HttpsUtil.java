package com.ai.yc.protal.web.utils;

import javax.net.ssl.*;
import java.io.*;
import java.net.Socket;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Nozomi on 11/3/2016.
 */
public class HttpsUtil {
    private static class TrustAnyTrustManager implements X509TrustManager {
        public void checkClientTrusted(X509Certificate[] chain, String authType)
                throws CertificateException {
        }
        public void checkServerTrusted(X509Certificate[] chain, String authType)
                throws CertificateException {
        }
        public X509Certificate[] getAcceptedIssuers() {
            return new X509Certificate[] {};
        }
    }

    private static class TrustAnyHostnameVerifier implements HostnameVerifier {
        public boolean verify(String hostname, SSLSession session) {
            return true;
        }
    }

    public static String HttpsPost(String url, String content, String charset) throws NoSuchAlgorithmException, KeyManagementException, IOException {
        SSLContext sc = SSLContext.getInstance("SSL");
        sc.init(null, new TrustManager[] { new TrustAnyTrustManager() }, new java.security.SecureRandom());
        URL console = new URL(url);
        HttpsURLConnection conn = (HttpsURLConnection) console.openConnection();
        conn.setSSLSocketFactory(sc.getSocketFactory());
        conn.setHostnameVerifier(new TrustAnyHostnameVerifier());
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);
        conn.connect();
        DataOutputStream out = new DataOutputStream(conn.getOutputStream());
        out.write(content.getBytes(charset));
        // 刷新、关闭
        out.flush();
        out.close();
        String responseData="";
        BufferedReader reader;
        if(conn.getResponseCode()!=200){
            reader = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
        }else{
            reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        }
        String line = "";
        StringBuffer buffer = new StringBuffer();
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }
        responseData = buffer.toString();
        reader.close();
        conn.disconnect();
        return responseData;
    }

    public static Map<String,String> httpsGet(String url,String charset)throws NoSuchAlgorithmException, KeyManagementException, IOException {
        Map<String,String> map = new HashMap<String,String>();
        SSLContext sc = SSLContext.getInstance("SSL");
        sc.init(null, new TrustManager[] { new TrustAnyTrustManager() }, new java.security.SecureRandom());
        URL console = new URL(url);
        HttpsURLConnection conn = (HttpsURLConnection) console.openConnection();
        conn.setSSLSocketFactory(sc.getSocketFactory());
        conn.setHostnameVerifier(new TrustAnyHostnameVerifier());
        conn.connect();
        // 获得工厂
        SSLSocketFactory factory = sc.getSocketFactory();
        String host = console.getHost();
        int port = console.getPort();
        // 从工厂获得Socket连接
        Socket socket = factory.createSocket(console.getHost(), 443);

        BufferedWriter out = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(),charset));
        BufferedReader in = null;
        out.write("GET " + url + " HTTP/1.0\n\n");
        out.flush();

        int code = conn.getResponseCode();
        map.put("code", String.valueOf(code));
        StringBuffer sb = new StringBuffer();
        if(code!=200){
            in = new BufferedReader(new InputStreamReader(conn.getErrorStream(), charset));
        }else{
            in = new BufferedReader(new InputStreamReader(conn.getInputStream(), charset));
        }

        String line;
        while ((line = in.readLine()) != null) {
            sb.append(line + "\n");
        }

        out.close();
        in.close();
        map.put("body", sb.toString());
        return map;
    }
}
