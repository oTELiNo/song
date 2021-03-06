package tw.com.view.resource;

import java.util.List;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.glassfish.jersey.server.mvc.Viewable;

import tw.com.model.vo.Member;
import tw.com.service.MemberService;


/**
 * 
 * @author chrisryo
 * 
 * 註 : @Consumes接受類型, @Produces返回類型
 *
 */ 
@Path("/member")
public class MemberRest {
	
	@Inject
    private MemberService memberService;
	
	@GET
	public Viewable init() {
		return new Viewable("/member");
	}
	
	/**
	 * 取所有資料
	 * 
	 * @return
	 * @throws Exception 
	 */
	@GET
	@Path("queryAll")
	@Produces(MediaType.APPLICATION_JSON)
	public List<Member> getAllMember() throws Exception {
		return memberService.getMember();
	}
	
	/**
	 *  寫入資料
	 *  
	 * @param member
	 * @return
	 * @throws Exception 
	 */
	@POST
	@Path("add")
	@Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public List<Member> getTodos(Member member) throws Exception {
		
		memberService.addUser(member.getName(), member.getPwd(), member.getEmail(), member.getPhone());
		return memberService.getMember();
    }
	
}