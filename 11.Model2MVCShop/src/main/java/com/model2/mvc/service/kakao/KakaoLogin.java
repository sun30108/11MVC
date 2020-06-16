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
    
    public String getAccessToken (String authorize_code) {
    	
    	System.out.println("GET AccessToken code START..");
    	
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            
            //    POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=1d004210b71f438f6c08da48d2b57cab");
            sb.append("&redirect_uri=http://localhost:8080/user/oauth");
            sb.append("&code=" + authorize_code);
            bw.write(sb.toString());
            bw.flush();
            
            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
 
            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String line = "";
            String result = "";
            
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            
            //jackson 으로 JSON 가져오기
            ObjectMapper om = new ObjectMapper();
            KakaoTokens kt = om.readValue(result, KakaoTokens.class); //지금은 그냥 카카오 객체 만들었는데 나중에는 Map에다 담아서 빼쓰자!
            
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
    
    //로그아웃
    public void kakaoLogout(String access_Token) {
    	
    	System.out.println("kakao LogOut method ");
    	
        String reqURL = "https://kapi.kakao.com/v1/user/logout";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
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
    
    //카카오로그인 유저 정보 가저오기 엑세스 토큰 써서
    public Map<String, Object> getUserInfo (String access_Token) {
        
    	System.out.println("getUserInfo method() ...");
    	
        //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        Map<String, Object> userInfo = new HashMap<>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            //    요청에 필요한 Header에 포함될 내용
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
            
            //DB에 넣을 유저 정보 , id = password, nickname = name
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
    

	///카카오 email, id로 쓰기위해 이메일 주소 파싱
    public String emailParsing(String userId) {
    	
    	System.out.println("Email parsing start..");
    	
    	String parseUser = userId.substring(0,userId.indexOf("@"));
    	System.out.println("pasing UserId : "+parseUser);
    	
    	return parseUser;
    }


}
