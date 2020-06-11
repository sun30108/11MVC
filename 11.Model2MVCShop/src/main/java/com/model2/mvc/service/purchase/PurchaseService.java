package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;


public interface PurchaseService {

	//���ŵ��
	public void addPurchase(Purchase purchase) throws Exception;
	
	//�������� ��ȸ  //�����̷¿��� ��ȸ?
	public Purchase getPurchase(int tranNo) throws Exception;
	
	//�������� ��ȸ
	public Purchase getPurchase2(int ProdNo) throws Exception;
	
	//PurchaseAll �Ѹ��� return Price
	public int getPurchaseAll(int tranNo) throws Exception;
	
	//���Ÿ���Ʈ ��ȸ
	public Map<String,Object> getPurchaseList(Search search,String buyerId) throws Exception;
	
	//�ǸŸ���Ʈ ��ȸ
	public Map<String,Object> getSaleList(Search search) throws Exception;
	
	//�������� ����
	public void updatePurcahse(Purchase purchase) throws Exception;
	
	//��ǰ�����ڵ� ����
	public void updateTranCode(Purchase purchase) throws Exception;
	
}