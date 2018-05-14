/*
  Created by IntelliJ IDEA.
  User: shan
  Date: 18.5.13
  Time: 22:58
*/

package justdj.top.controller;

import justdj.top.pojo.*;
import justdj.top.service.CourseService;
import justdj.top.service.KindService;
import justdj.top.service.TestDatabaseService;
import justdj.top.service.TestPaperService;
import justdj.top.util.KindHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigInteger;
import java.util.List;

@Controller
@RequestMapping("/course")
public class CourseController {

	@Autowired
	@Qualifier("courseService")
	private CourseService courseService;
	
	@Autowired
	@Qualifier("testDatabaseService")
	private TestDatabaseService testDatabaseService;
	
	@Autowired
	@Qualifier("kindService")
	private KindService kindService;
	
	@Autowired
	@Qualifier("testPaperService")
	private TestPaperService testPaperService;
	
	@RequestMapping("/info")
	private String courseInfo(@RequestParam("id") BigInteger courseId, Model model){
		
		List<Clazz> classList = courseService.selectClazzByCourseId(courseId);
		
		List<Knowledge> knowledgeList = courseService.selectKnowledgeByCourseId(courseId);
		
		List<TestDatabase> testDatabaseList = testDatabaseService.selectTestDatabaseByCourseId(courseId);
		
		List<TestPaper> testPaperList = testPaperService.selectTestPaperByCourseId(courseId);
		
		model.addAttribute("classList",classList);
		
		model.addAttribute("knowledgeList",knowledgeList);
		
		model.addAttribute("testDatabaseList",testDatabaseList);
		
		model.addAttribute("testPaperList",testPaperList);
	
		return "courseInfo";
	}

	
	@RequestMapping("/student")
	private String courseStudent(@RequestParam BigInteger id,Model model){
		List<User> studentList = courseService.selectStudentByClassId(id);
		model.addAttribute("studentList",studentList);
		return "courseStudent";
	}

	@RequestMapping("/testDatabase")
	private String courseTestDatabase(@RequestParam("id")BigInteger testDatabaseId,Model model){
		KindHelper.setKindService(kindService);
		List<String> kindName = KindHelper.getKindNameList();
		
//		for (String a:kindName){
//			List<Question> list = testDatabaseService.selectTestDatabaseQuestionByKindName(testDatabaseId,a);
//			model.addAttribute(a,list);
//		}
		
		model.addAttribute("kindName",kindName);
		
		List<Question> list = testDatabaseService.selectTestDatabaseQuestionByTDId(testDatabaseId);
		model.addAttribute("question",list);
		
		return "courseTestDatabase";
	}
}