<%@ page import="java.util.*, java.sql.*,tnt3.*, java.lang.*, act.util.*, java.lang.reflect.*"
%><%@ include file="utility.jsp"
%><%
	String accountId = nvl(request.getParameter("account"));
	String entityId	 = nvl(request.getParameter("entity"));
	
	try {
		out.println(getMaxYear(accountId,entityId));
	} catch (Exception e){
		throw e;
	}
%><%!
	public String getMaxYear(String accountId, String entityId) throws Exception{
		Connection 	 		conn		= null;
		PreparedStatement	ps 			= null;
		ResultSet			rs			= null;
		
		String dataSource	= "jdbc/development";
		String year			= null;
		
		try {
			conn = DBConnection.openConnection(dataSource);
			
			try {
				ps = conn.prepareStatement("select max(year) as \"year\""
										  +" from tnt_entity"
										  +" where accountid = ? and entityid = ?"
										  );
				ps.setString(1,accountId);
				ps.setString(2,entityId);
				
				rs = ps.executeQuery();
				
				if(!rs.isBeforeFirst()){
					year= null;
				}
				
				while(rs.next()){
					year = nvl(rs.getString("year"));
				}
				
			} catch (Exception e){
				throw e;
			}
		
		} catch (Exception e){
			throw e;
		} finally {
			try { conn.close(); } catch (Exception e){}
			try { ps.close(); } catch (Exception e){}
			try { rs.close();} catch (Exception e){}
		}
		
		return year;
		
	}
%>