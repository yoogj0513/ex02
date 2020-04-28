package com.yi.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sun.jmx.mbeanserver.Repository;

@Controller
public class DrageUploadController {
	
	@RequestMapping(value = "drag", method = RequestMethod.GET)
	public String dragForm() {
		return "dragUploadFile";
	}
	
	@ResponseBody
	@RequestMapping(value = "drag", method = RequestMethod.POST)
	public ResponseEntity<List<String>> drageUpload(String test, List<MultipartFile> files) throws IOException {
		ResponseEntity<List<String>> entity = null;
//		System.out.println("test : " + test);
//		for(MultipartFile file : files) {
//			System.out.println(file.getOriginalFilename());
//			System.out.println(file.getSize());
//		}
		
		//폴더 만들기
		String uploadPath = "c:/zzz/upload";
		File dir = new File(uploadPath);
		if(dir.exists() == false) {
			dir.mkdir();
		}
		
		try {
			//upload 처리
			List<String> fileList = new ArrayList<String>();
			for(MultipartFile file : files) {			
				UUID uid = UUID.randomUUID(); //중복되지 않는 고유한 키값을 반환함
				String saveName = uid.toString() + "_" + file.getOriginalFilename(); //중복되지 않게 이름 맞춤
				File target = new File(uploadPath +"/"+ saveName);
				FileCopyUtils.copy(file.getBytes(), target); //서버 upload 폴더 안에 파일 생성
				fileList.add(saveName);
			}
			entity = new ResponseEntity<List<String>>(fileList, HttpStatus.OK);			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<String>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteFile", method = RequestMethod.GET)
	public ResponseEntity<String> deleteFile(String filename){
		ResponseEntity<String> entity = null;
		
		System.out.println(filename);
		
		try {
			//file을 지움
			File file = new File("c:/zzz/upload/"+filename);
			file.delete();
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
