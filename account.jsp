<%@ page import="java.util.*, java.sql.*,tnt3.*, java.lang.*, act.util.*, java.lang.reflect.*"
%><%@ include file="utility.jsp"
%><%
	Account [] accounts = null;
	try {
		accounts = getAccount();
		out.println(toJson(accounts));
	} catch(Exception e) {
		out.println (e.toString());
	}
%><%!
	public class Account {
		public String accountId = null;
		public String loginId = null;
		public String name = null;
	}
	
	public Account [] getAccount() throws Exception{
		Connection 	 		conn		= null;
		PreparedStatement	ps 			= null;
		ResultSet			rs			= null;
		
		
		List <Account>		accounts	= new ArrayList<Account>();
		Account				account		= null;
		String dataSource				= "jdbc/development";
		
		try {
			conn = DBConnection.openConnection(dataSource);
			try {
				ps = conn.prepareStatement("select accountid, loginid, name, organization "
										  +" from tnt_accounts"
										  +" order by loginid"
										  );
				rs = ps.executeQuery();
				
				if(!rs.isBeforeFirst()){
					accounts.add(null);
				}
				
				while (rs.next()) {
					account = new Account();
					account.accountId = nvl(rs.getString("accountid"));
					account.loginId = nvl(rs.getString("loginid"));
					account.name = nvl(rs.getString("name"));
					accounts.add(account);
				}
			} catch (Exception e) {
				throw e;
			}
		
		} catch (Exception e){
			throw e;
		} finally {
			try { conn.close(); } catch (Exception e){}
			try { ps.close(); } catch (Exception e){}
			try { rs.close(); } catch (Exception e){}
		}
		
		Account [] accountArr	= accounts.toArray( new Account[accounts.size()]);
		return accountArr;
	}
%>