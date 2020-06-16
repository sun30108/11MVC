package com.model2.mvc.web.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.service.kakao.KakaoLogin;
import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ Controller
@Controller
@RequestMapping("/user/*")
public class UserController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	//kakaoLogin 
	@Autowired
	@Qualifier("kakaoLogin")
	private KakaoLogin kakao;
	//setter Method ���� ����
		
	public UserController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{
	
		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {

		System.out.println("/user/addUser : POST");
		//Business Logic
		userService.addUser(user);
		
		return "redirect:/user/loginView.jsp";
	}
	

	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);
		
		return "forward:/user/getUser.jsp";
	}
	

	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model �� View ����
		model.addAttribute("user", user);
		
		return "forward:/user/updateUser.jsp";
	}

	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		return "redirect:/user/getUser?userId="+user.getUserId();
	}
	
	
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{
		
		System.out.println("/user/logon : GET");

		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session ) throws Exception{
		
		System.out.println("/user/login : POST");
		System.out.println("user info : "+user);
		//Business Logic
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return "redirect:/index.jsp";
	}
		
	
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	
	@RequestMapping( value="checkDuplication", method=RequestMethod.POST )
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{
		
		System.out.println("/user/checkDuplication : POST");
		//Business Logic
		boolean result=userService.checkDuplication(userId);
		// Model �� View ����
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}

	
	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		System.out.println("FIRST SEARCH : "+search);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}
	
	//īī���α���
		@RequestMapping(value="/oauth",method=RequestMethod.GET)
	    public String kakaologin(@RequestParam("code") String code,HttpSession session, Model model, HttpServletRequest request)throws Exception{
			
			System.out.println("kakao Login oauth get code : GET");
			
			String access_Token = kakao.getAccessToken(code);
			
			System.out.println("Controller AccessToken : "+access_Token);
			
			
			//���� ���� �޾ƿ���
			Map<String, Object> userInfo = kakao.getUserInfo(access_Token);
			System.out.println("login Controller : " + userInfo);
		    
			//���� ���� �ʱ� ����
			String password = (String)userInfo.get("password"); //user ����id �� ��й�ȣ�� 
			String userName = (String)userInfo.get("userName"); //user nickNmae�� name����
			String userId = (String)userInfo.get("userId"); // user Email���̵� �Ľ��ؼ� �պκ��� id��
			
		    //    Ŭ���̾�Ʈ�� �̸����� ������ �� ���ǿ� �ش� �̸��ϰ� ��ū ���
		    if (userInfo.get("email") != null) {
		        session.setAttribute("email", userInfo.get("email"));
		        session.setAttribute("access_Token", access_Token);
		    }
		    
		    //addUser �ϱ����� user ���� ����
		    User apiUser = new User();
		    apiUser.setUserId(userId);
		    apiUser.setUserName(userName);
		    apiUser.setPassword(password);
		    
		    //������ īī��id�� db�� ������ �ٷ� �Ѿ�� ������ �߰��ѵ� �Ѿ��
		    if(userService.getUser(userId) == null) {
		    	userService.addUser(apiUser);
		    }
		    
		    System.out.println("APIUser Info : "+apiUser);
		    model.addAttribute("accessToken",access_Token);

		    //login logic ����
		    User dbUser=userService.getUser(apiUser.getUserId());
			
			if( apiUser.getPassword().equals(dbUser.getPassword())){
				session.setAttribute("user", dbUser);
			}
			
			return "redirect:/index.jsp";
	    }
		
	//īī���α׾ƿ�
		@RequestMapping(value = "/oauthLogout")
		public String oauthLogout(HttpSession session) {
			
			System.out.println("kakao LOGOUT START :");
			
		    kakao.kakaoLogout((String)session.getAttribute("access_Token"));
		    session.removeAttribute("access_Token");
		    session.removeAttribute("userId");
		    
		    return "/index.jsp";
		}
		///
}