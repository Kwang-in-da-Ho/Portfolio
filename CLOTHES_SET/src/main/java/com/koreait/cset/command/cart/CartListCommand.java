package com.koreait.cset.command.cart;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.CartDAO;
import com.koreait.cset.dao.StockDAO;
import com.koreait.cset.dto.CartJoinVO;
import com.koreait.cset.dto.MemberDTO;

public class CartListCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		HttpSession session = request.getSession();
		MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");
		String mId = loginDTO.getmId();
		
		CartDAO cDAO = sqlSession.getMapper(CartDAO.class);
		
		// 회원의 장바구니에 담긴 모든 항목 조회
		List<CartJoinVO> list = cDAO.cartListPage(mId);
		
		// 장바구니 항목의 재고량 가져오기 위한 StockDAO 객체
		StockDAO sDAO = sqlSession.getMapper(StockDAO.class);
		
		for(CartJoinVO cJVO : list) {
			// 각 상품에 할인율 적용된 값을 저장
			int pPrice = cJVO.getpPrice();
			double pDisrate = cJVO.getpDisrate();			
			int productPrice = (int) Math.round(pPrice * (1-(pDisrate/100)) / 100) * 100;			
			cJVO.setProductPrice(productPrice);
			
			// 각 장바구니 항목의 재고량 가져오기
			int sAmount = sDAO.stockSelectBypNopSize(cJVO.getpNo(), cJVO.getcSize());
			cJVO.setsAmount(sAmount);
			
		}
		
		int sumMoney = Math.round(cDAO.cartSumMoney(mId) / 100) * 100;
		
		int fee = sumMoney >= 100000 ? 0 : 3000;
		int total = sumMoney + fee;
		
		model.addAttribute("list", list);
		model.addAttribute("sumMoney", sumMoney);
		model.addAttribute("fee", fee);
		model.addAttribute("total", total);
		
	}

}
