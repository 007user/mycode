package com.xcn.service;

import com.xcn.dao.InfoDao;
import com.xcn.entity.Types;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class InfoServiceImp implements InfoService{

    @Resource
    private InfoDao infoDao;

    @Override
    public List<Types> queryInfo() {
        return infoDao.queryInfo();
    }
}
