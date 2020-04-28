package com.yi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UploadController {
	
	private String innerUploadPath = "/resources/upload";
	
	@RequestMapping(value = "inUp", method = RequestMethod.GET)
	public String innerUploadForm() {
		return "innerUploadForm";
	}
	
	@RequestMapping(value = "inUp", method = RequestMethod.POST)
	public String innerUploadReulst(String test, MultipartFile file, HttpServletRequest request, Model model) throws IOException {
		System.out.println("test : " + test);
		System.out.println("file : " + file);
		System.out.println(file.getOriginalFilename());
		System.out.println(file.getSize());
		
		// 자동 저장 되지 않기때문에 저장 시켜야 함
		String root = request.getSession().getServletContext().getRealPath("/"); //서버 내의 루트 주소
		File dir = new File(root + innerUploadPath);
		if(dir.exists() == false) {
			dir.mkdir();
		}
		
		UUID uid = UUID.randomUUID(); //중복되지 않는 고유한 키값을 반환함
		String saveName = uid.toString() + "_" + file.getOriginalFilename(); //중복되지 않게 이름 맞춤
		File target = new File(root + innerUploadPath +"/"+ saveName);
		FileCopyUtils.copy(file.getBytes(), target); //서버 upload 폴더 안에 파일 생성
		
		//보낼 데이터 : 파일이름, 작성자 
		model.addAttribute("test", test);
		model.addAttribute("file", saveName);
		
		return "innerUploadResult";
	}
	
	@RequestMapping(value = "inMultiUp", method = RequestMethod.GET)
	public String innerMultiUpload() {
		return "innerMultiUpload";
	}
	
	@RequestMapping(value = "inMultiUp", method = RequestMethod.POST)
	public String innerMultiUploadResult(String test, List<MultipartFile> files, HttpServletRequest request, Model model) throws IOException {//파일이 여러개일 때 List<>로 받아야 함
		System.out.println("test : " + test);
		for(MultipartFile file : files) {
			System.out.println("file : " + file.getOriginalFilename());
			System.out.println("size : "+file.getSize());
		}
		
		String root = request.getSession().getServletContext().getRealPath("/"); //서버 내부의 루트 주소
		File dir = new File(root + innerUploadPath);
		if(dir.exists() == false) {
			dir.mkdir();
		}
		
		List<String> fileList = new ArrayList<String>();
		for(MultipartFile file : files) {
			UUID uid = UUID.randomUUID(); //중복되지 않는 고유한 키값을 반환함
			String saveName = uid.toString() + "_" + file.getOriginalFilename(); //중복되지 않게 이름 맞춤
			File target = new File(root + innerUploadPath + "/" +saveName);
			FileCopyUtils.copy(file.getBytes(), target); //서버 upload 폴더 안에 파일 생성
			fileList.add(saveName);
		}
		
		model.addAttribute("test", test);
		model.addAttribute("fileList", fileList);
		
		return "innerMultiUploadResult";
	}
	
	@RequestMapping(value = "outUp", method = RequestMethod.GET)
	public String outUploadForm() {
		return "outUploadFileForm";
	}
	
	@RequestMapping(value = "outUp", method = RequestMethod.POST)
	public String outUploadResult(String test, MultipartFile file, Model model) throws IOException {
		String uploadPath = "c:/zzz/upload";
		File dir = new File(uploadPath);
		if(dir.exists() == false) {
			dir.mkdir();
		}
		
		UUID uid = UUID.randomUUID(); //중복되지 않는 고유한 키값을 반환함
		String saveName = uid.toString() + "_" + file.getOriginalFilename(); //중복되지 않게 이름 맞춤
		File target = new File(uploadPath +"/"+ saveName);
		FileCopyUtils.copy(file.getBytes(), target); //서버 upload 폴더 안에 파일 생성
		
		model.addAttribute("test", test);
		model.addAttribute("file", saveName);
		
		return "outUploadResult";
	}
	
	@ResponseBody
	@RequestMapping(value = "displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String filename){
		//서버에 있는 데이터가 아닌 외부 데이터를 들고오는 것이기 때문에 서버에서 전달할 수 없음 직접 전달할 수 있도록 데이터를 까서 전달
		
		ResponseEntity<byte[]> entity = null;
		System.out.println("displayFile -----" + filename);
		
		InputStream in = null;
		try {
			in = new FileInputStream("c:/zzz/upload/" + filename);
			String format = filename.substring(filename.lastIndexOf(".") + 1); //확장자
			MediaType mType = null;
			if(format.equalsIgnoreCase("png")) {
				mType = MediaType.IMAGE_PNG;
			} else if(format.equalsIgnoreCase("jpg") || format.equalsIgnoreCase("jpeg")) {
				mType = MediaType.IMAGE_JPEG;
			} else if(format.equalsIgnoreCase("gif")) {
				mType = MediaType.IMAGE_GIF;
			}
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(mType);
			
			//IOUtils.toByteArray(in) : byte while 처리 대신 함
			// 이미지 확장자 마다 디코딩하는 방법이 따로 있기 때문에 headers와 같은 처리를 해줘야 함
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
