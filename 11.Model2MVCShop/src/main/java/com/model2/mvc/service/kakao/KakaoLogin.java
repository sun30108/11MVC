package com.model2.mvc.service.kakao;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Service;

 
@Service("kakaoLogin")
public class KakaoLogin {
	
	String appKey = "1d004210b71f438f6c08da48d2b57cab";
	String redirectUri = "http://localhost:8080/user/oauth";
	String logoutRedirecUri = "http://localhost:8080";
	String differentEmailLoginUri = "https://accounts.kakao.com/login?continue=https%3A%2F%2Fkauth.kakao.com%2Foauth%2Fauthorize%3Fclient_id%3D1d004210b71f438f6c08da48d2b57cab%26redirect_uri%3Dhttp%3A%2F%2Flocalhost%3A8080%2Fuser%2Foauth%26response_type%3Dcode";
	
    
    public String getAccessToken (String authorize_code) {
    	
    	System.out.println("GET AccessToken code START..");
    	
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            //    POST ��û�� ���� �⺻���� false�� setDoOutput�� true��
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //    POST ��û�� �ʿ�� �䱸�ϴ� �Ķ���� ��Ʈ���� ���� ����
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id="+appKey);
            sb.append("&redirect_uri="+redirectUri);
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();
            
            //    ��� �ڵ尡 200�̶�� ����
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
 
            //    ��û�� ���� ���� JSONŸ���� Response �޼��� �о����
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            
            //jackson ���� JSON ��������
            ObjectMapper om = new ObjectMapper();
            KakaoTokens kt = om.readValue(result, KakaoTokens.class); //������ �׳� īī�� ��ü ������µ� ���߿��� Map���� ��Ƽ� ������!
            
            access_Token = kt.getAccess_token();
            refresh_Token = kt.getRefresh_token();
            
            System.out.println("access_token!! : " + access_Token);
            System.out.println("refresh_token!! : " + refresh_Token);
            
            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 
        
        return access_Token;
    }
    
    
    //īī���α��� ���� ���� �������� ������ ��ū �Ἥ
    public Map<String, Object> getUserInfo (String access_Token) {
        
    	System.out.println("getUserInfo method() ...");
    	
        //    ��û�ϴ� Ŭ���̾�Ʈ���� ���� ������ �ٸ� �� �ֱ⿡ HashMapŸ������ ����
        Map<String, Object> userInfo = new HashMap<>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //    ��û�� �ʿ��� Header�� ���Ե� ����
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);
            conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("charset", "UTF-8");
            
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("user Info response body : " + result);
            
            ObjectMapper om = new ObjectMapper();
            Map<String, Object> user = om.readValue(result, Map.class);
            
            String userUniqueId = om.writeValueAsString(user.get("id"));
            String properties = om.writeValueAsString(user.get("properties"));
            String kakaoAccount = om.writeValueAsString(user.get("kakao_account"));
            Map<String, Object> propertiesMap = om.readValue(properties, Map.class);
            Map<String, Object> kakao_account = om.readValue(kakaoAccount, Map.class);
            
            
            String nickname = (String)propertiesMap.get("nickname");
            String email = (String)kakao_account.get("email");
            String userId = emailParsing(email);
            
            //DB�� ���� ���� ���� , id = password, nickname = name
            userInfo.put("userId", userId);
            userInfo.put("password", userUniqueId);
            userInfo.put("userName", nickname);
            userInfo.put("email", email);
            
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return userInfo;
    }
    
  //�α׾ƿ�
    public void kakaoLogout(String access_Token) {
    	
    	System.out.println("KAKAO LOGOUT METHOD");
    	System.out.println("LogOut acToken : "+access_Token);
    	
        String reqURL = "https://kapi.kakao.com/v1/user/logout";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);
            
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            
            String result = "";
            String line = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("kakao logOut response result"+result);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    
    //īī�� �������(��������)
    public void kakaoUnlink(String access_Token) {
    	
    	
    	System.out.println("KAKAO UNLINK METHOD ");
    	
    	 String reqURL = "https://kapi.kakao.com/v1/user/unlink";
         
    	 try {
             URL url = new URL(reqURL);
             HttpURLConnection conn = (HttpURLConnection)url.openConnection();
             conn.setRequestMethod("POST");
             conn.setRequestProperty("Authorization", "Bearer "+access_Token);
             
             int responseCode = conn.getResponseCode();
             System.out.println("responseCode : " + responseCode);
             
             BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
             
             String result = "";
             String line = "";
             
             while ((line = br.readLine()) != null) {
                 result += line;
             }
             System.out.println("kakao Unlink response result : "+result);
         } catch (IOException e) {
             // TODO Auto-generated catch block
             e.printStackTrace();
         }
    }
    // �ٸ��������� �α����ϱ�
    public String differentEmailLogin() {
    	
    	return differentEmailLoginUri;
    }
    

	///īī�� email, id�� �������� �̸��� �ּ� �Ľ�
    public String emailParsing(String userId) {
    	
    	System.out.println("Email parsing start..");
    	
    	String parseUser = userId.substring(0,userId.indexOf("@"));
    	System.out.println("pasing UserId : "+parseUser);
    	
    	return parseUser;
    }


}
