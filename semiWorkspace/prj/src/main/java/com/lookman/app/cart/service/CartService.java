package com.lookman.app.cart.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.lookman.app.cart.dao.CartDao;
import com.lookman.app.cart.dto.CartHomeDto;
import com.lookman.app.cart.vo.CartItemVo;
import com.lookman.app.member.vo.MemberVo;

import static com.lookman.app.db.SQLSessionTemplate.*;

public class CartService {
	private final CartDao cdao;

	public CartService() {
		this.cdao = new CartDao();
	}

	public int addToCart(List<CartItemVo> items) throws Exception {
		SqlSession ss = getSqlSession();

		int result = cdao.addToCart(ss, items);

		if (result > 0) {
			ss.commit();
		} else {
			ss.rollback();
		}

		ss.close();

		return result;
	}

	public List<CartHomeDto> getCartItems(MemberVo loginMemberVo) throws Exception {
		SqlSession ss = getSqlSession();
		
		List<CartHomeDto> dtoList = cdao.getCartItems(ss, loginMemberVo);
System.out.println(dtoList);
		ss.close();
		
		return dtoList;
	}

}
