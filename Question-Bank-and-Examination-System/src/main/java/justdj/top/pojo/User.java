/*
  Created by IntelliJ IDEA.
  User: shan
  Date: 18.5.6
  Time: 14:00
*/

package justdj.top.pojo;



import lombok.Data;

import java.io.Serializable;
import java.math.BigInteger;

@Data
public class User implements Serializable{
	private BigInteger id;
	
	private String account;
	
	private String password;
	
	private String salt;
	
	private String name;
	
	private Short age;
	
	private char sex;
	
	private Boolean use;
	
}
