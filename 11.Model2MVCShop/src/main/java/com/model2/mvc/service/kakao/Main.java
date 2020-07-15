package com.model2.mvc.service.kakao;

import java.io.File;
import java.util.HashMap;
import java.util.Map;



/**
 * SDK�� ���� ���� access token�� �����Ͻø�
 * REST API�� �׽�Ʈ�� ���� �� �ִ� �����Դϴ�.
 * Ǫ�� �˸� ���� API�� �׽�Ʈ�Ͻ÷��� admin key �����ؾ� �մϴ�.
 */

public class Main {

    private static KakaoAPI apiHelper = new KakaoAPI();

    public static void main(String[] args) throws InterruptedException {
        new Main().test();
    }

    /**
     * �׽�Ʈ�� �ʿ��� api ���� �ּ��� Ǯ�� �׽�Ʈ�ϼ���.
     */
    public void test() {
        // access token ����
        apiHelper.setAccessToken("[YOUR APP KEY]");

        // Ǫ�� �˸��̳� ���� ���̵� ����Ʈ�� �ʿ��� �� ���� �մϴ�. 
        // (�𺧷��۽� ���� �ۼ��� �޴��� ���ø� �ֽ��ϴ�)
        apiHelper.setAdminKey("[YOUR ADMIN KEY]");

        testUserManagement();
        testKakaoStory();
        testKakaoTalk();
        testPush();
    }

    public void testUserManagement() {

        Map<String, String> paramMap;

        /*
        // �� ����� ���� ��û (signup �Ŀ� ��� ����)
        apiHelper.me();
        */

        // �� ����
        // apiHelper.signup();

        /*
        // �� ����(�Ķ����)
        paramMap = new HashMap<String, String>();
        paramMap.put("properties", "{\"nickname\":\"test\"}");
        apiHelper.signup(paramMap);
        */

        // �� Ż��
        //apiHelper.unlink();

        // �� �α׾ƿ�
        apiHelper.logout();

        /*
        // �� ����� ���� ������Ʈ
        paramMap = new HashMap<String, String>();
        paramMap.put("properties", "{\"nickname\":\"test\"}");
        apiHelper.updatProfile(paramMap);
        */

        // �� ����� ����Ʈ ��û
        //apiHelper.getUserIds();

        /*
        // �� ����� ����Ʈ ��û (�Ķ����)
        paramMap = new HashMap<String, String>();
        paramMap.put("limit", "100");
        paramMap.put("fromId", "1");
        paramMap.put("order", "asc");
        apiHelper.getUserIds(paramMap);
        */
    }

    public void testKakaoStory() {

        final String TEST_MYSTORY_ID = "[TEST MY STORY ID]";
        final String TEST_SCRAP_URL = "https://developers.kakao.com";

        // on Linux or Mac
        final File TEST_UPLOAD_FILE1 = new File("/xxx/sample1.png");
        final File TEST_UPLOAD_FILE2 = new File("/xxx/sample2.png");

        // on windows
        // final File TEST_UPLOAD_FILE = new File("C:\\~~/sample.png");

        Map<String, String> paramMap;

        /*
        // ���丮 �������� ��û
        apiHelper.storyProfile();
        */

        /*
        // ���丮 �������� Ȯ��
        apiHelper.isStoryUser();
        */

        /*
        // �������� �����丮 ���� ��û
        // https://dev.kakao.com/docs/restapi#��������-�����丮-����-��û
        apiHelper.getMyStories();
        */

        /*
        // �������� �����丮 ���� ��û (Ư�� ���̵� ����)
        paramMap = new HashMap<String, String>();
        paramMap.put("last_id", TEST_MYSTORY_ID);
        apiHelper.getMyStories(paramMap);
        */

        /*
        // �����丮 ���� ��û
        // https://dev.kakao.com/docs/restapi#īī�����丮-�����丮-����-��û
        paramMap = new HashMap<String, String>();
        paramMap.put("id", TEST_MYSTORY_ID);
        apiHelper.getMyStory(paramMap);
        */

        // �����丮 ����
        // paramMap = new HashMap<String, String>();
        // paramMap.put("id", TEST_MYSTORY_ID);
        // apiHelper.deleteMyStory(paramMap);

        // ���丮 ������ ���� �Ķ����. �ʿ��� �͸� �����Ͽ� ���.
        paramMap = new HashMap<String, String>();
        paramMap.put("permission", "A"); // A : ��ü����, F: ģ�����Ը� ����, M: ��������
        paramMap.put("enable_share", "false"); // ���� ��� ��� ����
        paramMap.put("android_exec_param", "cafe_id=1234"); // �� �̵��� �߰� �Ķ����
        paramMap.put("ios_exec_param", "cafe_id=1234");
        paramMap.put("android_market_param", "cafe_id=1234");
        paramMap.put("ios_market_param", "cafe_id=1234");

        // �� �������� ��쿡�� content�� �ʼ����� ��ũ/���� �������� ���� �ɼ�.
        paramMap.put("content", "�� ���� ������ �޲ٰ� �װ��� ���Ƿ� ����� �̸� ���Ͽ� īī������ �� ���� �÷��� ���񽺸� �����մϴ�.");

        String result;

        /*
        // �� ������
        result = apiHelper.postNote(paramMap);
        if (result != null && result.indexOf("code\":-") == -1) {
            String postedId = result.split("\"")[3];
            System.out.println("postedId:" + postedId);
            if (apiHelper.deleteMyStory(postedId).equals(""))
                System.out.println("deleted test my story " + postedId);
        }
        */

        /*
        // ���� ������ (�ִ� 10������ ����)
        String uploadedImageObj = apiHelper.uploadMulti(
                new File[]{
                        TEST_UPLOAD_FILE1,
                        TEST_UPLOAD_FILE2
                });
        if (uploadedImageObj != null) {
            System.out.println("uploaded file(s) successfully.");
            System.out.println(uploadedImageObj);
            paramMap.put("image_url_list", uploadedImageObj);
            result = apiHelper.postPhoto(paramMap);
            if (result != null && result.indexOf("code\":-") == -1) {
                String postedId = result.split("\"")[3];
                System.out.println("postedId:" + postedId);
                if (apiHelper.deleteMyStory(postedId).equals(""))
                    System.out.println("deleted test my story " + postedId);
            }

        } else {
            System.out.println("failed to upload");
        }
        */

        /*
        // ��ũ ������
        final String linkInfoObj = apiHelper.getLinkInfo(TEST_SCRAP_URL);
        if (linkInfoObj != null) {
            paramMap.put("link_info", linkInfoObj);
            result = apiHelper.postLink(paramMap);
            if (result != null && result.indexOf("code\":-") == -1) {
                String postedId = result.split("\"")[3];
                System.out.println("postedId:" + postedId);
                if (apiHelper.deleteMyStory(postedId).equals(""))
                    System.out.println("deleted test my story " + postedId);
            }
        }
        */

    }

    public void testKakaoTalk() {

        // īī���� ������ ��û
        apiHelper.talkProfile();
    }

    public void testPush() {

        Map<String, String> paramMap;

        // �Ķ���� ����
        // @param uuid ������� ���� ID. 1~(2^63 -1), ���ڰ��� ����
        // @param push_type  gcm or apns
        // @param push_token apns(64��) or GCM���κ��� �߱޹��� push token
        // @param uuids ����� ������ ID ����Ʈ (�ִ� 100������ ����)

        // Ǫ�� �˸� ���� API�� �׽�Ʈ�Ͻ÷��� admin key �����ؾ� �մϴ�.

        /*
        // Ǫ�� ���
        paramMap = new HashMap<String, String>();
        paramMap.put("uuid", "10000");
        paramMap.put("push_type", "gcm");
        paramMap.put("push_token", "xxxxxxxxxx");
        paramMap.put("device_id", "");
        apiHelper.registerPush(paramMap);
        */

        /*
        // Ǫ�� ��ū ��ȸ
        paramMap = new HashMap<String, String>();
        paramMap.put("uuid", "10000");
        apiHelper.getPushTokens(paramMap);
        */

        /*
        // Ǫ�� ����
        paramMap = new HashMap<String, String>();
        paramMap.put("uuid", "10000");
        paramMap.put("push_type", "gcm");
        paramMap.put("push_token", "xxxxxxxxxx");
        apiHelper.deregisterPush(paramMap);
        */

        /*
        // Ǫ�� ������
        paramMap = new HashMap<String, String>();
        paramMap.put("uuids", "[\"1\",\"2\", \"3\"]");
        apiHelper.sendPush(paramMap);
        */
    }
}
